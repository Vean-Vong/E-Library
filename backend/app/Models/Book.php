<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'author',
        'isbn',
        'description',
        'year',
        'publisher',
        'cover_image',
    ];

    public function borrows()
    {
        return $this->hasMany(Borrow::class);
    }
}