import 'package:flutter/material.dart';
import 'package:libraries/Service_api/Borrow_Service.dart';

class BorrowPage extends StatefulWidget {
  final String bookTitle;
  final String bookImage;

  BorrowPage({
    required this.bookTitle,
    required this.bookImage,
  });

  @override
  State<BorrowPage> createState() => _BorrowState();
}

class _BorrowState extends State<BorrowPage> {
  TextEditingController title = TextEditingController();
  TextEditingController borrowerName = TextEditingController();
  TextEditingController borrowDate = TextEditingController();
  TextEditingController dueDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to open date picker dialog
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
    }
  }

  Future<void> saveBorrowData() async {
    if (_formKey.currentState?.validate() != true) return;

    final response = await BorrowServices.borrowBook(
      title.text.trim(),
      borrowerName.text.trim(),
      borrowDate.text.trim(),
      dueDate.text.trim(),
    );

    if (response.statusCode == 201) {
      // Success: show success message and reset form
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Book borrowed successfully!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo[900],
        ),
      );
      Navigator.pop(context);
      // Reset form fields
      title.clear();
      borrowerName.clear();
      borrowDate.clear();
      dueDate.clear();
    } else {
      showErrorSnackBar("Failed to borrow the book. Please try again.");
    }
  }

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text("Borrow Book"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              widget.bookImage,
              height: 200,
              fit: BoxFit.cover,
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                        labelText: 'Book Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the book title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: borrowerName,
                      decoration: InputDecoration(
                        labelText: "Your Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: borrowDate,
                      decoration: InputDecoration(
                        labelText: "Borrow Date (YYYY-MM-DD)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onTap: () => selectDate(
                          context, borrowDate), // Open date picker on tap
                      readOnly: true, // Make it read-only
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Borrow Date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: dueDate,
                      decoration: InputDecoration(
                        labelText: "Due Date (YYYY-MM-DD)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onTap: () => selectDate(
                          context, dueDate), // Open date picker on tap
                      readOnly: true, // Make it read-only
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Due Date';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: saveBorrowData,
                  child: Text('Submit'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
