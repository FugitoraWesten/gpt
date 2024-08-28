import 'package:flutter/material.dart';
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
        backgroundColor: Colors.teal, // Custom app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose the difficulty level',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30), // Spacing before the buttons
            _buildLevelButton(
              context,
              'Beginner',
              'Basic questions to get you started.',
              Colors.greenAccent.shade700,
            ),
            SizedBox(height: 20),
            _buildLevelButton(
              context,
              'Intermediate',
              'Challenge yourself with tougher questions.',
              Colors.orangeAccent.shade700,
            ),
            SizedBox(height: 20),
            _buildLevelButton(
              context,
              'Advanced',
              'Prepare for the most difficult questions.',
              Colors.redAccent.shade700,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, String level, String description, Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 25),
        backgroundColor: color, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 8, // Shadow effect
      ),
      onPressed: () {
        // Navigate to the Questions Screen for the selected level
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsScreen(level: level, jsonFilePath: Jsonpath.beginner,),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            level,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White text color for contrast
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70, // Slightly muted white for description
            ),
          ),
        ],
      ),
    );
  }
}