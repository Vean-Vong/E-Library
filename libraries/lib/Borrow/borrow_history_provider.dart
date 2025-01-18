import 'package:flutter/material.dart';

class BorrowItem {
  final String image;
  final String title;
  final String author;
  final String submit;
  final String date;
  final String status;

  BorrowItem({
    required this.image,
    required this.title,
    required this.author,
    required this.submit,
    required this.date,
    required this.status,
  });
}

class BorrowHistoryProvider extends ChangeNotifier {
  final List<BorrowItem> _borrowHistory = [];

  List<BorrowItem> get borrowHistory => List.unmodifiable(_borrowHistory);

  void addBorrowItem(BorrowItem item) {
    _borrowHistory.add(item);
    notifyListeners();
  }
}
