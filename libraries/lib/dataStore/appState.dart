import 'package:get/get.dart';

class appState extends GetxController {
  // Books store from SQl database

  var book = ''.obs; // To store the selected book title
  var books = <Map<String, dynamic>>[].obs; // List to store all the books

  var favoriteBooks = <Map<String, String>>[].obs;

  // Add a book to favorites
  void addToFavorites(Map<String, String> book) {
    favoriteBooks.add(book);
  }

  // Remove a book from favorites
  void removeFromFavorites(Map<String, String> book) {
    favoriteBooks.removeWhere((item) => item['title'] == book['title']);
  }

  // Check if the book is in favorites
  bool isFavorite(Map<String, String> book) {
    return favoriteBooks.any((item) => item['title'] == book['title']);
  }

  // Define the userId getter
  final userId = ''.obs;

// Store Username
  var username = '';

// Books Store for offline
  var bookStore = '';
  var bookStores = [
    {
      'title': 'BTTH',
      'author': 'Heavenly Silkworm Potato',
      'description': 'A wonderful book about Flutter development.',
      'image': 'assets/images/XiaoYan.jpg',
    },
    {
      'title': 'Jade Dynasty',
      'author': 'Ching Siu-tung',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/XiaoFan.jpg',
    },
    {
      'title': 'Renegade Immortal',
      'author': 'Er Gen',
      'description': 'A wonderful book about Flutter development.',
      'image': 'assets/images/WangLin.jpg',
    },
    {
      'title': 'Lin Dong',
      'author': 'John Doe',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/LinDong.jpg',
    },
    {
      'title': 'Soul Land',
      'author': 'Tang Jia San Shao',
      'description': 'A wonderful book about Flutter development.',
      'image': 'assets/images/TangSan.jpg',
    },
    {
      'title': 'Perfect World',
      'author': 'Rie Aruga',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/ShiHao.jpg',
    },
    {
      'title': 'Throne of Seal',
      'author': 'Tang Jia San Shao',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/HaoChen.jpg',
    },
    {
      'title': 'Soul Land 2',
      'author': 'Tang Jia San Shao',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/Souland2.jpg',
    },
    {
      'title': 'The Great Ruler',
      'author': 'Tian Can Tu Dou',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/MuChen.jpg',
    },
    {
      'title': 'Swallowed Star',
      'author': 'Wo Chi Xi Hong Shi',
      'description': 'Learn how to build amazing mobile apps.',
      'image': 'assets/images/LouFeng.jpg',
    },
  ];
}
