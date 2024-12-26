import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:libraries/Service/Constant.dart';

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password, String phoneNumber) async {
    Map<String, String> data = {
      "name": name,
      "email": email,
      "password": password,
      "phone_number": phoneNumber,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/register');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + 'auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static submitRequest(Map<String, Object> requestData) {}
}
