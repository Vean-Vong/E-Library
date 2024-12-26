<?php

namespace App\Http\Controllers;

use App\Models\Book;
use Illuminate\Http\Request;

class BookController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // Retrieve all books from the database
        $books = Book::all();

        // Return the books as a JSON response
        return response()->json($books);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate input data
        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'author' => 'required|string|max:255',
            'isbn' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'year' => 'required|integer|min:1000|max:' . date('Y'),
            'publisher' => 'nullable|string|max:255',
            'cover_image' => 'nullable|string|max:255',
        ]);

        // Check if a book with the same ISBN already exists
        $existingBook = Book::where('isbn', $validatedData['isbn'])->first();

        if ($existingBook) {
            return response()->json([
                'message' => 'A book with this ISBN already exists.',
                'book' => $existingBook
            ], 400); // 400 status code indicates a bad request (duplicate entry)
        }

        // Create the book using the validated data
        $book = Book::create($validatedData);

        // Return response with the newly created book
        return response()->json(['book' => $book], 201); // HTTP status 201 indicates successful creation
    }


    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Book  $book
     * @return \Illuminate\Http\Response
     */
    public function show(Book $book)
    {
        // Return a JSON response with the specified book
        return response()->json($book);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Book  $book
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Book $book)
    {
        // Validate input data for updating a book
        $validatedData = $request->validate([
            'title' => 'required|string|max:255',
            'author' => 'required|string|max:255',
            'isbn' => 'required|string|max:255|unique:books,isbn,' . $book->id, // Unique, except for the current book's ID
            'description' => 'nullable|string|max:1000',
            'year' => 'required|integer|min:1000|max:' . date('Y'),
            'publisher' => 'nullable|string|max:255',
            'cover_image' => 'nullable|string|max:255',
        ]);

        // Update the book with the validated data
        $book->update($validatedData);

        // Return a JSON response with the updated book
        return response()->json(['book' => $book]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Book  $book
     * @return \Illuminate\Http\Response
     */
    public function destroy(Book $book)
    {
        // Delete the book
        $book->delete();

        // Return a success message
        return response()->json(['message' => 'Book deleted successfully']);
    }
}