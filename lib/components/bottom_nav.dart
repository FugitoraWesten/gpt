import 'package:flutter/material.dart';
import 'package:gpt/screens/home_screen.dart';
import 'nav.dart'; // Import the nav component

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic based on the selected index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/quizzes');
        break;
      case 2:
        Navigator.pushNamed(context, '/progress');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavComponent(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
    );
  }
}
