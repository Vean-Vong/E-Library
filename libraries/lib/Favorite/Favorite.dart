import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraries/Library/DetailLibrary.dart';
import 'package:libraries/dataStore/appState.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<appState>();

    return Scaffold(
      body: Obx(() {
        // Check if there are any favorite books
        if (favoriteController.favoriteBooks.isEmpty) {
          return Center(
            child: Text(
              'No favorites added yet.',
              style: GoogleFonts.abhayaLibre(fontSize: 20),
            ),
          );
        }

        return ListView.builder(
          itemCount: favoriteController.favoriteBooks.length,
          itemBuilder: (context, index) {
            final book = favoriteController.favoriteBooks[index];
            return GestureDetector(
              onTap: () {
                // Pass data to the Detail page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailLibrary(
                      title: book['title'] ?? 'Unknown Title',
                      author: book['author'] ?? 'Unknown Author',
                      image: book['image'] ?? 'default_image_path',
                      description:
                          book['description'] ?? 'No description available.',
                      bookName: '',
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  title: Text(
                    book['title'] ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    book['author'] ?? 'Unknown Author',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  leading: Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200], 
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: book['cover_image'] != null &&
                              book['cover_image']!.isNotEmpty
                          ? Image.network(
                              book['cover_image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image,
                                    size: 50, color: Colors.grey);
                              },
                            )
                          : book['image'] != null && book['image']!.isNotEmpty
                              ? Image.network(
                                  book['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image,
                                        size: 50, color: Colors.grey);
                                  },
                                )
                              : Icon(Icons.broken_image,
                                  size: 50, color: Colors.grey),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _showDeleteDialog(context, favoriteController, book);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// Function to show a confirmation dialog
void _showDeleteDialog(
  BuildContext context,
  appState favoriteController,
  Map<String, dynamic> book,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Are you sure?',
          style: GoogleFonts.abhayaLibre(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do you want to remove "${book['title']}" from your favorites?',
          style: GoogleFonts.abhayaLibre(fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.abhayaLibre(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text(
              'Delete',
              style: GoogleFonts.abhayaLibre(fontSize: 16, color: Colors.red),
            ),
            onPressed: () {
              favoriteController.removeFromFavorites(book.map((key, value) =>
                  MapEntry(key, value.toString()))); // Delete the book
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}
