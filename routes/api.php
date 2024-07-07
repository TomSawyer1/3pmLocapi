<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\{ AuthTokenController, ContactController, AbonnementController, StripeController, PaymentsController, UserController };

// Prefix: http://127.0.0.1:8000/api/

// Auth
Route::post("/register", [AuthTokenController::class, "register"]); // s'inscrire
Route::post("/login", [AuthTokenController::class, "login"]);  // se login
Route::post("/logout", [AuthTokenController::class, "logout"])->middleware('auth:sanctum'); // se deconnecter

// User 
Route::put('/user', [AuthTokenController::class, "updateUser"])->middleware('auth:sanctum'); // update ses informations 
Route::delete('/user', [AuthTokenController::class, "deleteUser"])->middleware('auth:sanctum'); // supprimer son compte
Route::get('/user', [UserController::class, "index"])->middleware('auth:sanctum'); // information de l'utilisateur 

// Stripe Checkout
Route::post('/stripe/checkout', [StripeController::class, "checkout"])->middleware('auth:sanctum'); // prendre un abonnement 
Route::get('/stripe/customer', [StripeController::class, 'customer'])->middleware('auth:sanctum'); // Acceder a la page gestion des abonnement (portail)
Route::post('/stripe/webhook', [StripeController::class, "webhook"]); // Ecouter le webhook (event)

// Payments
Route::get('/payments', [PaymentsController::class, 'index'])->middleware('auth:sanctum'); // Récupérer les paiements

// Contact
Route::post('/contact',[ContactController::class, "send"]); // envois formulaire de contact 

// Abonnement
Route::get('/subscription',[AbonnementController::class, "index"]); // obtenir la liste de mes abonnements
