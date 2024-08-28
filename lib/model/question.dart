import 'package:flutter/material.dart';
import 'package:gpt/screens/question_screen.dart';

class Question extends StatelessWidget {
  final String level;

  Question({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level Questions'),
      ),
      body: Center(
        // child: QuestionsScreen(jsonFilePath: Jsonpath.beginner),
      ),
    );
  }
}
