<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $req)
    {
        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|unique:users',
            'password' => 'required|string|min:6',
            'phone_number' => 'required|string'
        ];

        $validator = Validator::make($req->all(), $rules);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // Store the password as plain text (not recommended for security reasons)
        $password = $req->password;

        // Create new user in users table with plain text password
        $user = User::create([
            'name' => $req->name,
            'email' => $req->email,
            'password' => $password, // Store plain text password
            'phone_number' => $req->phone_number
        ]);

        // Create token for the newly registered user
        $token = $user->createToken('Personal Access Token')->plainTextToken;

        // Return response with user data and token
        $response = ['user' => $user, 'token' => $token];
        return response()->json($response, 200);
    }

    public function login(Request $req)
    {
        // Validate inputs
        $rules = [
            'email' => 'required|email',
            'password' => 'required|string'
        ];
        $req->validate($rules);

        // Find user by email
        $user = User::where('email', $req->email)->first();

        // Check if user exists and password matches (compare plain text password)
        if ($user && $user->password === $req->password) { // Compare plain text passwords
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['user' => $user, 'token' => $token];
            return response()->json($response, 200);
        }

        // Return error if credentials are incorrect
        $response = ['message' => 'Incorrect email or password'];
        return response()->json($response, 400);
    }
}