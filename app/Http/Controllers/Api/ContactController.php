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
            "message" => "required|string|min:50", // Assurez-vous que ce champ correspond à celui envoyé depuis le formulaire
        ]);

        $data = $request->only('name', 'email', 'subject', 'message');

        try {
            Mail::send([], [], function ($message) use ($data) {
                $message->to('contact@webstart.com')
                        ->subject($data['subject'])
                        ->setBody("Name: {$data['name']}\\nEmail: {$data['email']}\\nMessage: {$data['message']}");
            });

            return response()->json(['success' => 'Votre message a été envoyé avec succès !']);
        } catch (\Exception $e) {
            Log::error('Mail send error: ' . $e->getMessage());
            return response()->json(['error' => 'Il y a eu une erreur lors de l\'envoi de votre message.']);
        }
    }
}
