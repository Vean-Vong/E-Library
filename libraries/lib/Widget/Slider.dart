import 'dart:async';
import 'package:flutter/material.dart';

class CustomDotIndicator extends StatefulWidget {
  const CustomDotIndicator({super.key});

  @override
  State<CustomDotIndicator> createState() => _CustomDotIndicatorState();
}

class _CustomDotIndicatorState extends State<CustomDotIndicator> {
  int _currentIndex = 0;

  final List<String> _images = [
    'assets/images/j.jpg',
    'assets/images/p.jpg',
    'assets/images/Tum_Teav.jpg',
    'assets/images/j.jpg',
    'assets/images/j.jpg',
    'assets/images/j.jpg',
  ];

  // Controller for PageView
  final PageController _pageController = PageController();

  // Timer for auto-slide
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the auto-slide functionality
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (_timer != null) {
      _timer!.cancel(); // Cancel the timer when the widget is disposed
    }
    super.dispose();
  }

  // Function to start auto-slide
  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      // Check if it's the last page
      if (_currentIndex < _images.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0; // Reset to the first page if it's the last one
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {}); // Trigger rebuild to update the dot indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image Slider (PageView)
        Container(
          height: 150,
          width: 400,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        SizedBox(height: 5),
        // Dot Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.animateToPage(
                  _currentIndex,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: _currentIndex == index ? 15 : 10,
                width: _currentIndex == index ? 15 : 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.black : Colors.grey,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
