// DetailLibrary.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:libraries/Borrow/Borrow.dart';
import 'package:libraries/dataStore/appState.dart';

class DetailLibrary extends StatelessWidget {
  final String title;
  final String author;
  final String image;
  final String description;

  DetailLibrary({
    required this.title,
    required this.author,
    required this.image,
    required this.description,
    required String bookName,
  });

  @override
  Widget build(BuildContext context) {
    final appStateController = Get.find<appState>();

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo[900],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          title,
          style: GoogleFonts.adamina(color: Colors.white),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: Obx(() {
              // Use the full data map for checking if the book is a favorite
              bool isFavorite = appStateController.isFavorite({
                'title': title,
                'author': author,
                'image': image,
                'description': description,
              });

              return IconButton(
                onPressed: () {
                  // Add or remove from favorites
                  if (isFavorite) {
                    appStateController.removeFromFavorites({
                      'title': title,
                      'author': author,
                      'image': image,
                      'description': description,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.indigo[900],
                          content: Text(
                            'Removed from favorites successfully!',
                            style: TextStyle(color: Colors.white),
                          )),
                    );
                  } else {
                    appStateController.addToFavorites({
                      'title': title,
                      'author': author,
                      'image': image,
                      'description': description,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added to favorites successfully!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.indigo[900],
                      ),
                    );
                  }
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Image
              // Center(
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(12),
              //     child: Image.asset(
              //       image,
              //       width: double.infinity,
              //       height: 300,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),

              // Book Title
              Text(
                title,
                style: GoogleFonts.adamina(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),

              // Book Author
              Text(
                'By $author',
                style: GoogleFonts.abhayaLibre(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 10),

              // Book Description
              Text(
                description,
                style: GoogleFonts.abhayaLibre(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BorrowPage(
                bookTitle: title,
                bookImage: image,
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
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
