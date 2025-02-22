import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _currentIndex = 0;

  List<Widget> _body = [
    Icon(Icons.home, size: 150),
    Icon(Icons.search, size: 150),
    Icon(Icons.person, size: 150),
    Icon(Icons.settings, size: 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
child: _currentIndex < _body.length ? _body[_currentIndex] : _body[0],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Strona główna",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Szukaj",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Ustawienia",
          ),
        ],
        selectedItemColor: Colors.blue, // Kolor wybranej ikony
        unselectedItemColor: Colors.grey, // Kolor niewybranych ikon
        backgroundColor: Colors.white, // Kolor tła nawigacji
      ),
    );
  }
}