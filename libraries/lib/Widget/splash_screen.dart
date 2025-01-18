import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:libraries/Auth/Login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startFadeInAnimation();
    _startFadeOutAnimation();
    _navigateToHomePage();
  }

  void _startFadeInAnimation() {
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _startFadeOutAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  void _navigateToHomePage() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: AnimatedOpacity(
              duration: Duration(seconds: 3),
              opacity: _opacity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'assets/images/Logo.png',
                    width: 300,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'E-Libraries',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
