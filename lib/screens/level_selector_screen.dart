import 'package:flutter/material.dart';
import 'package:gpt/components/bottom_nav.dart';
import 'package:gpt/screens/question_screen.dart';

class Jsonpath {
  static const String beginner = "beginner";
  static const String intermediate = "intermidiate";
  static const String advanced = "advanced";
}

class LevelSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Level'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.teal,
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
              Jsonpath.beginner,
              'Basic questions to get you started.',
              Colors.greenAccent.shade700,
            ),
            SizedBox(height: 20),
            _buildLevelButton(
              context,
              Jsonpath.intermediate,
              'Challenge yourself with tougher questions.',
              Colors.orangeAccent.shade700,
            ),
            SizedBox(height: 20),
            _buildLevelButton(
              context,
              Jsonpath.advanced,
              'Prepare for the most difficult questions.',
              Colors.redAccent.shade700,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget _buildLevelButton(
      BuildContext context, String level, String description, Color color) {
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
        // Navigate selected level
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuestionsScreen(level: level, jsonFilePath: level),
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
