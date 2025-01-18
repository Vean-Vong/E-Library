import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BorrowHistory extends StatelessWidget {
  // Sample list of borrow history items
  final List<BorrowItem> borrowItems = [
    BorrowItem('assets/images/j.jpg', 'កុលាបប៉ៃលិន', 'ញ៉ុក ថែម', 'Submitted on',
        '5 Jun, 2016', 'Borrowed'),
    BorrowItem('assets/images/Mealea.jpg', 'ផ្កាស្រពោន', 'នូ​ ហាច',
        'Submitted on', '10 Sep, 2021', 'Returned'),
    BorrowItem('assets/images/Tum_Teav.jpg', 'ទុំទាវ', 'ភិក្ខុ សោម',
        'Submitted on', '12 Dec, 2020', 'Borrowed'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo[900],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'ប្រវត្តិខ្ចីសៀវភៅ',
          style: GoogleFonts.freehand(color: Colors.white),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: borrowItems.length,
          itemBuilder: (context, index) {
            return BorrowItemCard(item: borrowItems[index]);
          },
        ),
      ),
    );
  }
}

class BorrowItem {
  final String image;
  final String title;
  final String author;
  final String submit;
  final String date;
  final String status;

  BorrowItem(
      this.image, this.title, this.author, this.submit, this.date, this.status);
}

class BorrowItemCard extends StatelessWidget {
  final BorrowItem item;

  BorrowItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.author,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.submit,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.date,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Text(
              item.status,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: item.status == 'Borrowed' ? Colors.blue : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
