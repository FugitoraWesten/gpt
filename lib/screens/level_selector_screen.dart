import 'package:flutter/material.dart';

import 'package:gpt/components/components.dart';
import 'package:gpt/screens/question_screen.dart';


class LevelSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Level'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to Home Screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildLevelButton(context, 'Beginner',
                'Basic questions to get you started.', Colors.green, 0),
            SizedBox(height: 16),
            _buildLevelButton(context, 'Intermediate',
                'Challenge yourself with tougher questions.', Colors.orange, 1),
            SizedBox(height: 16),
            _buildLevelButton(context, 'Advanced',
                'Prepare for the most difficult questions.', Colors.red, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, String level,
      String description, Color color, int levelId) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Colors.blue,
      ),
      onPressed: () {
        // Navigate to the Questions Screen for the selected level
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsScreen(),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            level,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(description),
        ],
      ),
    );
  }
}

class QuestionScreen extends StatelessWidget {
  final String level;

  QuestionScreen({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level Questions'),
      ),
      body: Center(
        child: Text('Questions for $level level go here.'),
      ),
    );
  }
}
