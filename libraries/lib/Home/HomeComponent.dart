import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraries/Widget/Slider.dart';

import '../dataStore/appState.dart';

class HomeComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appStateController = Get.find<appState>();


    return SingleChildScrollView(
      // Enable scrolling for the entire page
      child: Column(
        children: [
          SizedBox(height: 5),
          // Place CustomDotIndicator here
          CustomDotIndicator(),
          Container(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  'My Books',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          // GridView wrapped in Obx for reactive updates
          Obx(
            () => SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.6, // Set a fixed height for the GridView
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Three items per row
                  crossAxisSpacing: 8, // Space between cards horizontally
                  mainAxisSpacing: 8, // Space between cards vertically
                  childAspectRatio:
                      0.8, // Control aspect ratio (width/height ratio)
                ),
                itemCount: appStateController.books.length,
                itemBuilder: (context, index) {
                  final book = appStateController.books[index];
                  return GestureDetector(
                    onTap: () {
                      appStateController.book.value = book['title']!;
                      Navigator.pushNamed(context, '/Detail');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Book Image
                          ClipPath(
                            child: Image.asset(
                              book['image']!,
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Book Title
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              book['title']!,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Book Year
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              'និពន្ធដោយ: ${book['author']}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
