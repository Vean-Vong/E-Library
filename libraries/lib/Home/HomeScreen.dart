import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraries/Favorite/Favorite.dart';
import 'package:libraries/Home/HomeComponent.dart';
import 'package:libraries/Library/Library.dart';
import 'package:libraries/dataStore/appState.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Widget> _pages = [
    HomeComponent(),
    Library(),
    Favorite(),
  ];

  // Mock list of books
  final List<Map<String, String>> _bookList = [
    {'name': 'BTTH', 'author': 'Heavenly Silkworm Potato'},
    {'name': 'Jade Dynasty', 'author': 'Ching Siu-tung'},
    {'name': 'Renegade Immortal', 'author': 'Er Gen'},
    {'name': 'Soul Land', 'author': 'Tang Jia San Shao'},
    {'name': 'Perfect World', 'author': 'Rie Aruga'},
  ];

  List<Map<String, String>> _filteredBooks = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _searchQuery = '';
      _filteredBooks = [];
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isNotEmpty) {
        _filteredBooks = _bookList
            .where((book) => book['name']!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
            .toList();
      } else {
        _filteredBooks = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    appState d = Get.find<appState>();
    int hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo[900],
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search book name...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: _updateSearchQuery,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting !',
                    style: GoogleFonts.adamina(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 5),
                    child: Text(
                      d.username,
                      style: GoogleFonts.adamina(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
        leading: _isSearching
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _stopSearch,
              )
            : Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Logo.png'),
                  radius: 20,
                ),
              ),
        actions: _isSearching
            ? [
                IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    _searchController.clear();
                    _updateSearchQuery('');
                  },
                ),
              ]
            : [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: _startSearch,
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (String value) {
                    if (value == 'Profile') {
                      Navigator.pushNamed(context, '/BookDetailPage');
                    } else if (value == 'Borrow') {
                      Navigator.pushNamed(context, '/BorrowHistory');
                    } else if (value == 'Logout') {
                      Navigator.pushNamed(context, '/Login');
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Profile',
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile', style: GoogleFonts.adamina()),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Borrow',
                      child: ListTile(
                        leading: Icon(Icons.history),
                        title: Text('Borrow History',
                            style: GoogleFonts.adamina()),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Logout',
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          'Logout',
                          style: GoogleFonts.adamina(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
      ),
      body: _isSearching
          ? _buildSearchResults()
          : _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo[900],
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.abhayaLibre(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.abhayaLibre(
          fontSize: 12,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredBooks.isEmpty) {
      return Center(
        child: Text(
          _searchQuery.isEmpty
              ? 'Start typing to search for books.'
              : 'No results found for "$_searchQuery".',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredBooks.length,
      itemBuilder: (context, index) {
        final book = _filteredBooks[index];
        return ListTile(
          title: Text(book['name']!),
          subtitle: Text(book['author']!),
          leading: Icon(Icons.menu_book, color: Colors.indigo[900], size: 30),
          onTap: () {
            // Navigate to book details or perform other actions
          },
        );
      },
    );
  }
}
