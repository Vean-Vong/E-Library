<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;
use App\Models\BookBorrowing; // Use BookBorrowing model
use App\Models\Borrow;
use App\Models\User;
use Carbon\Carbon;

class BorrowController extends Controller
{
    /**
     * Display a listing of the borrowed books.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // Retrieve all borrow records
        $borrowings = Borrow::with('book', 'user')->get(); // You can load related books and users
        return response()->json($borrowings);
    }

    /**
     * Store a newly created borrowing record in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate the incoming request data
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'book_id' => 'required|exists:books,id',
            'due_date' => 'required|date|after:today',
        ]);

        try {
            // Find the user and the book
            $user = User::findOrFail($validated['user_id']);
            $book = Book::findOrFail($validated['book_id']);

            // Check if the book is already borrowed by someone else
            $existingBorrow = Borrow::where('book_id', $book->id)
                ->whereNull('returned_at') // Book is not returned yet
                ->first();

            if ($existingBorrow) {
                return response()->json(['message' => 'This book is already borrowed by another user.'], 400);
            }

            // Create a new borrowing record
            $borrow = new Borrow([
                'user_id' => $user->id,
                'book_id' => $book->id,
                'borrowed_at' => Carbon::now(),
                'due_date' => $validated['due_date'],
            ]);

            $borrow->save();

            return response()->json([
                'message' => 'Book borrowed successfully!',
                'borrow' => $borrow
            ], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error: ' . $e->getMessage()], 500);
        }
    }


    /**
     * Display the specified borrowed book.
     *
     * @param  \App\Models\BookBorrowing  $borrow
     * @return \Illuminate\Http\Response
     */
    public function show(Borrow $borrow)
    {
        return response()->json($borrow);
    }

    /**
     * Update the specified borrowing record in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\BookBorrowing  $borrow
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Borrow $borrow)
    {
        // Example: Update the due date of the borrowing record
        $request->validate([
            'due_date' => 'required|date|after:today',
        ]);

        $borrow->due_date = $request->due_date;
        $borrow->save();

        return response()->json(['message' => 'Borrowing record updated successfully!', 'borrow' => $borrow]);
    }

    /**
     * Remove the specified borrowing record from storage.
     *
     * @param  \App\Models\BookBorrowing  $borrow
     * @return \Illuminate\Http\Response
     */
    public function destroy(Borrow $borrow)
    {
        // Mark the book as returned (you can use a "returned_at" column to mark it as returned)
        $borrow->returned_at = Carbon::now();
        $borrow->save();

        return response()->json(['message' => 'Book returned successfully!']);
    }
}
