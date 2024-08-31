import 'package:flutter/material.dart';
import 'package:gpt/components/bottom_nav.dart';
import 'package:gpt/screens/level_selector_screen.dart';
import 'package:gpt/screens/progress_screen.dart';
import 'screens/home_screen.dart';
import 'components/bottom_nav.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      initialRoute: '/',
      routes: {
        '/': (context) => BottomNavigation(),
        '/home': (context) => HomeScreen(),
        '/quizzes': (context) => LevelSelectorScreen(),
        '/progress': (context) => ProgressScreen(
              totalQuestions: 0,
              correctAnswers: 0,
              incorrectAnswers: 0,
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
