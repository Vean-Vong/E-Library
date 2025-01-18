import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (fixed at the top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'assets/images/XiaoYan.jpg'), // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content below the image that scrolls
          Positioned(
            top: 200, // This value should match the height of the image
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Author
                    const Text(
                      'Title Title',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Text(
                      'Author Name',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border)),
                            Text('Favorite'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.menu_book_outlined)),
                            Text('Borrow'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.share)),
                            Text('Share'),
                          ],
                        ),
                      ],
                    ),
                    // Description Section
                    Text(
                      'Story',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Make description scrollable
                    Text(
                      'This is a detailed description of the book. It could include information about the storyline, the author’s background, and why the book is worth reading. The description helps readers understand the book’s themes and content better. This is a detailed description of the book. It could include information about the storyline, the author’s background, and why the book is worth reading. The description helps readers understand the book’s themes and content better. This is a detailed description of the book. It could include information about the storyline, the author’s background, and why the book is worth reading. The description helps readers understand the book’s themes and content better. This is a detailed description of the book. It could include information about the storyline, the author’s background, and why the book is worth reading. The description helps readers understand the book’s themes and content better.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    // You can add more content here if necessary
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
