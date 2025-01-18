import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final box = GetStorage();
    bool isLoggedIn = box.read('isLoggedIn') ?? false; 

    if (isLoggedIn) {
      return null;
    } else {
      return RouteSettings(name: '/Login');
    }
  }
}
