import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraries/Borrow/BorrowPage%20.dart';
import 'package:libraries/dataStore/appState.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool _isExpanded = false; // Track whether the description is expanded or not

  @override
  Widget build(BuildContext context) {
    final appStateController = Get.find<appState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 24, 77, 137),
        title: Text(
          appStateController.book.value,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Container(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  )))
        ],
      ),
      body: Obx(() {
        final selectedBook = appStateController.books.firstWhere(
            (book) => book['title'] == appStateController.book.value);

        // Get the description text and decide whether to show full or truncated
        String description = selectedBook['description']!;
        String displayText = _isExpanded
            ? description
            : description.length > 100
                ? description.substring(0, 600) + '...'
                : description;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(1),
                  child: Image.network(
                    selectedBook['image']!,
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 1000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.grey,
                            thickness: 3, // Thickness of the divider
                            indent: 200, // Space from the left
                            endIndent: 200, // Space from the right
                          ),
                          SizedBox(height: 1),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${selectedBook['title']}',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   ' ${selectedBook['year']}',
                                //   style: TextStyle(fontSize: 16),
                                // ),
                                Text(
                                  'និពន្ធដោយ: ${selectedBook['author']}',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isExpanded = !_isExpanded;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  elevation: 1,
                                ),
                                child: Text(
                                  _isExpanded ? "Show Less" : "Read More",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BorrowPage(
                                        bookTitle: selectedBook['title']!,
                                        bookImage: selectedBook['image']!,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  elevation: 1,
                                ),
                                child: Text(
                                  "Borrow Book",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            displayText,
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
