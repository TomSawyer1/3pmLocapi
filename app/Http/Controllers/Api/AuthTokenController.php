<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use App\Http\Controllers\Controller;
use App\Mail\UserRegistered;
use App\Mail\UserDeleted;
use Illuminate\Support\Facades\Log;

class AuthTokenController extends Controller
{
    public function register(Request $request) {
        $request->validate([
            "first_name" => "required",
            "last_name" => "required",
            "email" => "required|email",
            "password" => "required|min:8",
        ]);
        
        // Vérifier si l'utilisateur existe déjà
        $userExists = User::where('email', $request->email)->exists();

        if ($userExists) {
            return response()->json(['error' => "User already exists"], 409);
        }

        // Créer un nouvel utilisateur
        $user = User::create([
            'name' => $request->first_name . ' ' . $request->last_name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'stripe_customer_id' => '', // Si nécessaire, sinon retirer ce champ
        ]);

        // Créer un token pour l'utilisateur
        $token = $user->createToken("client");
        $user->token = $token->plainTextToken;

        // Envoyer l'e-mail de confirmation d'inscription
        try {
            // Envoyer l'e-mail de confirmation d'inscription
            Mail::to($user->email)->send(new UserRegistered($user));
        } catch (\Exception $e) {
            Log::error('Error sending registration email: ' . $e->getMessage());
            return response()->json(['message' => 'User registered, but email not sent.'], 500);
        }

        return response()->json([
            'message' => 'User successfully registered',
            'user' => $user
        ], 201);
    }

    public function login(Request $request) {
        $request->validate([
            "email" => "required|email",
            "password" => "required|min:8",
        ]);
    
        $user = User::where('email', $request->email)->first();
    
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => "Invalid credentials"], 401);
        }
    
        $user->tokens()->where("name", "client")->delete();
        $token = $user->createToken("client");
    
        $user->token = $token->plainTextToken;
    
        // Stocker le jeton dans le localStorage
        return response()->json([
            'message' => 'Login successful',
            'user' => $user,
            'token' => $user->token
        ]);
    }
    

    public function logout(Request $request) {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logout successful'
        ], 204);
    }

    public function updateUser(Request $request) {
        $user = $request->user();

        $request->validate([
            'first_name' => 'sometimes|required|string',
            'last_name' => 'sometimes|required|string',
            'email' => 'sometimes|required|email|unique:users,email,' . $user->id,
        ]);

        $user->update([
            'name' => $request->first_name . ' ' . $request->last_name,
            'email' => $request->email,
        ]);

        return response()->json([
            'message' => 'User updated successfully',
            'user' => $user
        ]);
    }

    public function deleteUser(Request $request) {
        $user = $request->user();

        $user->tokens()->delete();
        $user->delete();

        // Envoyer l'e-mail de confirmation de suppression
        Mail::to($user->email)->send(new UserDeleted($user));

        return response()->json([
            'message' => 'User deleted successfully'
        ]);
    }
}
