<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;

class ContactController extends Controller
{
    public function send(Request $request) {
        $request->validate([
            "name" => "required|string|max:255",
            "email" => "required|email|max:255",
            "subject" => "required|string|max:255",
            "message" => "required|string|min:50",
        ]);

        $data = $request->only('name', 'email', 'subject', 'message');

        try {
            Mail::raw("Name: {$data['name']}\nEmail: {$data['email']}\nMessage: {$data['message']}", function ($message) use ($data) {
                // envois mail a ladmin
                $message->to('thomas.andradeve@gmail.com')
                        ->subject($data['subject'])
                        ->from($data['email'], $data['name']);
            });

            return response()->json(['success' => 'Votre message a été envoyé avec succès !']);
        } catch (\Exception $e) {
            Log::error('Mail send error: ' . $e->getMessage());
            return response()->json(['error' => 'Il y a eu une erreur lors de l\'envoi de votre message.']);
        }
    }
}
