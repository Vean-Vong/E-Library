import 'dart:convert';
import 'package:http/http.dart' as http;

// Constants
const String baseURL = "http://127.0.0.1:8000/api/";
const Map<String, String> headers = {"Content-Type": "application/json"};

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password, String phoneNumber) async {
    final Map<String, String> data = {
      "name": name,
      "email": email,
      "password": password,
      "phone_number": phoneNumber,
    };

    final body = json.encode(data);
    final url = Uri.parse(baseURL + 'auth/register');

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

  /// Login Method
  static Future<http.Response> login(
      String username, String password, param2) async {
    final Map<String, String> data = {
      "name": username, // Changed from "email" to "name"
      "password": password,
    };

    final body = json.encode(data);
    final url = Uri.parse(baseURL + 'auth/login');

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
