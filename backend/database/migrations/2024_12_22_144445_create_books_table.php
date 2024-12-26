<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id(); // Auto-incrementing primary key
            $table->string('title'); // Book title
            $table->string('author'); // Author name
            $table->string('isbn')->unique(); // ISBN number (unique)
            $table->text('description'); // Short description of the book
            $table->integer('year')->nullable(); // Publication year
            $table->string('publisher')->nullable(); // Publisher name
            $table->string('cover_image')->nullable(); // Cover image URL or path (optional)
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('books');
    }
};