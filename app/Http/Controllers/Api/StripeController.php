<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Log;
use App\Models\{Product, User};

class StripeController extends Controller
{
    public function checkout(Request $request)
    {
        $request->validate([
            'product_id' => 'required|integer'
        ]);

        $product = Product::findOrFail($request->product_id);

        Log::info('Stripe Secret from env: ' . env('STRIPE_SECRET'));

        \Stripe\Stripe::setApiKey(env("STRIPE_SECRET"));

        try {
            $stripeCheckoutSession = \Stripe\Checkout\Session::create([
                'line_items' => [[
                    'price' => $product->stripe_price_id,
                    'quantity' => 1,
                ]],
                'mode' => 'subscription',
                'allow_promotion_codes' => true,
                'metadata' => [
                    'user_id' => $request->user()->id
                ],
                'success_url' => env('APP_URL') . '/successpay',
                'cancel_url' => env('APP_URL') . '/unsuccesspay',
            ]);

            return response()->json(['url' => $stripeCheckoutSession->url]);
        } catch (\Exception $e) {
            Log::error('Stripe Checkout Error: ' . $e->getMessage());
            return response()->json(['error' => 'There was an error processing your payment.'], 500);
        }
    }

    public function webhook(Request $request)
    {
        $stripe = new \Stripe\StripeClient(env("STRIPE_SECRET"));
        $endpoint_secret = env("STRIPE_WEBHOOK_SECRET");
    
        $payload = @file_get_contents('php://input');
        $sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
        $event = null;
    
        try {
            $event = \Stripe\Webhook::constructEvent(
                $payload, $sig_header, $endpoint_secret
            );
        } catch (\UnexpectedValueException $e) {
            // Invalid payload
            http_response_code(400);
            exit();
        } catch (\Stripe\Exception\SignatureVerificationException $e) {
            // Invalid signature
            http_response_code(400);
            exit();
        }
    
        switch ($event->type) {
          
          // evenement si checkout reussi 
            case 'checkout.session.completed':
                $userId = $event->data->object->metadata->user_id;
                $stripeCustomerId = $event->data->object->customer;
    
                User::where('id', $userId)->update(['stripe_customer_id' => $stripeCustomerId]);
                Log::info('Stripe checkout session completed for user: ' . $userId);
                break;

            // evenement si user change d'abonnement depuis le portail
            case 'customer.subscription.updated':
                $subscription = $event->data->object;
                $stripeCustomerId = $subscription->customer;
                $currentPeriodEnd = date('Y-m-d H:i:s', $subscription->current_period_end);
    
                $user = User::where('stripe_customer_id', $stripeCustomerId)->first();
                if ($user) {
                    $user->subscription_status = $subscription->status;
                    $user->current_period_end = $currentPeriodEnd;
                    $user->save();
                    Log::info('Stripe subscription updated for user: ' . $user->id);
                }
                break;
            // You can add more event types here
            default:
                Log::warning('Unhandled event type: ' . $event->type);
                break;
        }
    
        Log::debug('Stripe event:', ['event' => $event]);
    
        http_response_code(200);
    }
    
    public function customer(Request $request)
    {
        $stripe = new \Stripe\StripeClient(env("STRIPE_SECRET"));
        $stripeCustomerId = $request->user()->stripe_customer_id;

        if (!$stripeCustomerId) {
            return response()->json(['error' => "User does not have subscription"], 400);
        }

        try {
            Log::info('Creating customer portal session for customer: ' . $stripeCustomerId);

            $customerPortal = $stripe->billingPortal->sessions->create([
                'customer' => $stripeCustomerId,
                'return_url' => env('APP_URL') . '/user-profile',
            ]);

            Log::info('Customer portal session created successfully.');

            return response()->json(['url' => $customerPortal->url]);
        } catch (\Exception $e) {
            Log::error('Stripe Customer Portal Error: ' . $e->getMessage());
            return response()->json(['error' => 'There was an error accessing the billing portal.'], 500);
        }
    }
}
