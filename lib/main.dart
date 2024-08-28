import 'package:flutter/material.dart';
import 'package:gpt/screens/home_screen.dart';
import 'package:gpt/screens/level_selector_screen.dart';
import 'package:gpt/screens/question_screen.dart';

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
      home: LevelSelectorScreen(),
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}
