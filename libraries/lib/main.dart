import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraries/Auth/Login.dart';
import 'package:libraries/Auth/Register.dart';
import 'package:libraries/DetailScreen/Detail.dart';
import 'package:libraries/History/Borrow_History.dart';
import 'package:libraries/Home/HomeScreen.dart';
import 'package:libraries/Widget/splash_screen.dart';
import 'package:libraries/dataStore/appState.dart';

void main() {
  Get.put(appState());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/HomeScreen': (context) => HomeScreen(),
        '/Detail': (context) => Detail(),
        '/Register': (context) => Register(),
        '/Login': (context) => Login(),
        '/BorrowHistory': (context) => BorrowHistory(),
      },
    );
  }
}
