<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\{Payment, User};

class PaymentsController extends Controller
{
    public function index(Request $request)
    {
        // Assurez-vous que l'utilisateur est authentifié
        $user = $request->user();

        // Récupérer les paiements de l'utilisateur
        $payments = Payment::where('user_id', $user->id)->get();

        return response()->json($payments);
    }
}
