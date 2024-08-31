import 'package:flutter/material.dart';
import 'package:gpt/components/bottom_nav.dart';
import '../model/write_file.dart';
import '../model/read_file.dart';
import 'package:gpt/screens/level_selector_screen.dart';

class ResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final FileWriter _fileWriter = FileWriter();

  ResultsScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  @override
  Widget build(BuildContext context) {
    // Automatically save progress when the screen is built
    saveProgress();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Results"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Quiz Completed!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            buildResultRow("Total Questions", totalQuestions),
            buildResultRow("Correct Answers", correctAnswers),
            buildResultRow("Incorrect Answers", incorrectAnswers),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LevelSelectorScreen()),
                );
              },
              child: const Text("Restart Quiz"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  void saveProgress() async {
    Map<String, dynamic> data = {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Load the existing data, add the new data, and save it
    FileReader _fileReader = FileReader();
    List<Map<String, dynamic>> existingData = await _fileReader.readJsonFromFile('quiz_results');
    existingData.add(data);
    await _fileWriter.writeJsonToFile(existingData, 'quiz_results');
  }

  Widget buildResultRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
