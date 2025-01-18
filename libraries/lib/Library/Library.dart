import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraries/Library/DetailLibrary.dart';
import 'package:libraries/dataStore/appState.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appState d = Get.find<appState>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(
                    'Anime Book',
                    style: GoogleFonts.abhayaLibre(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust based on your design
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.58,
                ),
                itemCount: d.bookStores.length,
                itemBuilder: (context, index) {
                  final bookStore = d.bookStores[index]; // Access book data
                  return GestureDetector(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => DetailLibrary(
                            title: bookStore['title']!,
                            author: bookStore['author']!,
                            image: bookStore['image']!,
                            description: bookStore['description']!,
                            bookName: '',
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Book Image
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              bookStore['image']!,
                              width: double.infinity,
                              height: 260,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // // Book Title
                          // Padding(
                          //   padding: EdgeInsets.only(top: 5),
                          //   child: Text(
                          //     bookStore['title']!,
                          //     style: GoogleFonts.adamina(
                          //       fontSize: 15,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black,
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),

                          // // Book Author
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 2),
                          //   child: Text(
                          //     'By ${bookStore['author']!}',
                          //     style: GoogleFonts.abhayaLibre(
                          //       fontSize: 11,
                          //       color: Colors.black,
                          //     ),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
