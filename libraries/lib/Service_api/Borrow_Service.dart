import 'dart:convert';
import 'package:http/http.dart' as http;


const String baseURL = "http://127.0.0.1:8000/api/";
const Map<String, String> headers = {"Content-Type": "application/json"};

class BorrowServices {
  static Future<http.Response> borrowBook(
      String bookTitle, String borrowerName, String borrowDate, String dueDate) async {
    final Map<String, String> data = {
      "book_title": bookTitle,
      "borrower_name": borrowerName,
      "borrow_date": borrowDate,
      "due_date": dueDate,
    };

    final body = json.encode(data);
    final url = Uri.parse(baseURL + 'api/borrow');  

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      print("Response: ${response.body}");
      return response;
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
