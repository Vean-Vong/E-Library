import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../dataStore/appState.dart';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  bool isLoading = true;
  List<dynamic> books = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(Get.find<appState>());
  }

  // Function to fetch books from API
  Future<void> fetchBooks(dynamic appStateController) async {
    final url = 'http://127.0.0.1:8000/api/books';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          books = data['data'];
          isLoading = false;
        });
        appStateController.books.value =
            List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load books');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching books: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStateController = Get.find<appState>();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              CarouselSlider(
                items: books.map((book) {
                  return GestureDetector(
                    onTap: () {
                      appStateController.book.value = book['title']!;
                      Navigator.pushNamed(context, '/Detail');
                    },
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(book['cover_image'] ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 900),
                  viewportFraction: 0.3,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Row(
                  children: [
                    Text(
                      'Trending Book',
                      style: GoogleFonts.adamina(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: GridView.builder(
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.80,
                        ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return GestureDetector(
                            onTap: () {
                              appStateController.book.value = book['title']!;
                              Navigator.pushNamed(context, '/Detail');
                            },
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: book['cover_image'] != null &&
                                        book['cover_image'].isNotEmpty
                                    ? Image.network(
                                        book['cover_image'],
                                        width: double.infinity,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Icons.menu_book)),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
