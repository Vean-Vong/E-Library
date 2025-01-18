import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraries/Borrow/Borrow.dart';
import 'package:libraries/dataStore/appState.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
  final String title;

  final String author;

  final String image;

  final String description;

  Detail({
    required this.title,
    required this.author,
    required this.image,
    required this.description,
    required String bookName,
  });
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    final appStateController = Get.find<appState>();
    final favoriteController = Get.put(appState());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        // backgroundColor: Colors.indigo[900],
        title: Text(
          'រឿង ${appStateController.book.value}',
          style: GoogleFonts.freehand(color: Colors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                final selectedBook = appStateController.books.firstWhere(
                  (book) => book['title'] == appStateController.book.value,
                  orElse: () => {},
                );
                if (selectedBook.isNotEmpty) {
                  // Check if the book is already in favorites
                  if (favoriteController.isFavorite(selectedBook
                      .map((key, value) => MapEntry(key, value.toString())))) {
                    // Remove from favorites
                    favoriteController.removeFromFavorites(selectedBook
                        .map((key, value) => MapEntry(key, value.toString())));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: Duration(milliseconds: 700),
                          backgroundColor: Colors.indigo[900],
                          content: Text('Removed from favorites successfully!',
                              style: TextStyle(color: Colors.white))),
                    );
                  } else {
                    // Add to favorites
                    favoriteController.addToFavorites(selectedBook
                        .map((key, value) => MapEntry(key, value.toString())));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: Duration(milliseconds: 700),
                          backgroundColor: Colors.indigo[900],
                          content: Text('Added to favorites successfully!',
                              style: TextStyle(color: Colors.white))),
                    );
                  }
                }
              },
              icon: Obx(() {
                final selectedBook = appStateController.books.firstWhere(
                  (book) => book['title'] == appStateController.book.value,
                  orElse: () => {},
                );

                if (selectedBook.isNotEmpty &&
                    favoriteController.isFavorite(selectedBook.map(
                        (key, value) => MapEntry(key, value.toString())))) {
                  return Icon(
                    Icons.favorite,
                    color: Colors
                        .white, // Change icon color when added to favorites
                  );
                } else {
                  return Icon(
                    Icons.favorite_border,
                    color: Colors.white, // Default icon color
                  );
                }
              }),
            ),
          ),
        ],
      ),
      body: Obx(() {
        // Find the selected book from the list of books
        final selectedBook = appStateController.books.firstWhere(
          (book) => book['title'] == appStateController.book.value,
          orElse: () => {}, // Return empty map if not found
        );

        // Handle if the book is not found
        if (selectedBook.isEmpty) {
          return Center(child: Text("Book not found"));
        }

        // Use the correct key to access the book's image and other details
        String bookImage = selectedBook['cover_image'] ?? '';
        String description = selectedBook['description'] ?? '';

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the book's image
                      if (bookImage.isNotEmpty)
                        Image.network(
                          bookImage,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                          height: 250,
                        )
                      else
                        Icon(
                          Icons.menu_book,
                          size: 100,
                          color: Colors.grey,
                        ),
                      Divider(
                        color: Colors.grey,
                        thickness: 2,
                        indent: 200,
                        endIndent: 200,
                      ),

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ' ${selectedBook['title']}',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'អ្នកនិពន្ធ: ${selectedBook['author']}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('អត្ថបទសង្ខេប',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        // Ensure the selected book is available for navigation
        final selectedBook = appStateController.books.firstWhere(
          (book) => book['title'] == appStateController.book.value,
          orElse: () => {}, // Return empty map if not found
        );

        if (selectedBook.isEmpty) {
          return SizedBox(); // Return empty widget if the book is not found
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BorrowPage(
                  bookTitle: selectedBook['title']!,
                  bookImage: selectedBook['cover_image']!,
                ),
              ),
            );
          },
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                height: 50,
                color: Colors.indigo[900],
                child: Center(
                  child: Text(
                    'Borrow Book',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
