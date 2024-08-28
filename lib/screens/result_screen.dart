import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gpt/screens/level_selector_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;

  ResultsScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    // Save the current score when the result screen is displayed
    _saveScore();

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Quiz Completed!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              buildResultRow("Total Questions", totalQuestions),
              buildResultRow("Correct Answers", correctAnswers),
              buildResultRow("Incorrect Answers", incorrectAnswers),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LevelSelectorScreen()),
                  );
                },
                child: Text("Restart Quiz"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget buildResultRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Save the score to SharedPreferences
  Future<void> _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve existing score history
    List<String>? scoreHistory = prefs.getStringList('scoreHistory') ?? [];

    // Create a new score entry
    String newScore = 'Total: $totalQuestions, Correct: $correctAnswers, Incorrect: $incorrectAnswers';

    // Add the new score to the history
    scoreHistory.add(newScore);

    // Save the updated score history back to SharedPreferences
    await prefs.setStringList('scoreHistory', scoreHistory);
  }
}
