import 'package:flutter/material.dart';
import 'package:libraries/Home/HomeComponent.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeScreen> {
  int _selectedIndex = 0;
  // List of pages for each tab (You can add more tabs if needed)
  final List<Widget> _pages = [
    HomeComponent(),
    Center(
      child: Text("Library"),
    ),
    Center(child: Text("Favorite")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 77, 137),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/Logo.png'),
            radius: 20,
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.sort,
                color: Colors.white,
              ),
              tooltip: 'Menu',
              onSelected: (String value) {
                if (value == 'Profile') {
                } else if (value == 'Borrow') {
                  Navigator.pushNamed(context, '/BorrowHistory');
                } else if (value == 'Logout') {
                  Navigator.pushNamed(context, '/Login');
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Borrow',
                  child: ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Borrow History'),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Logout',
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              hintText: 'Find your book',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),

      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
}
