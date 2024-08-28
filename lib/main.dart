import 'package:flutter/material.dart';
import 'package:gpt/screens/home_screen.dart';

void main() {
  runApp(SATPrepApp());
}

class SATPrepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAT Prep',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}
