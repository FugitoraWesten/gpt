import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:gpt/screens/result_screen.dart';

class Question {
  final String question;
  final List<String> options;
  final String answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }
}

class QuestionsScreen extends StatefulWidget {
  @override
  _QuestionsScreen createState() => _QuestionsScreen();
}

class _QuestionsScreen extends State<QuestionsScreen> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  int totalDurationInSeconds = 3660; // Example time
  Timer? timer;

  int correctAnswers = 0;
  int incorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions().then((data) {
      setState(() {
        questions = data;
      });
      startTimer();
    });
  }

  Future<List<Question>> loadQuestions() async {
    final jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => Question.fromJson(json)).toList();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (totalDurationInSeconds == 0) {
        timer.cancel();
        showTimeUpDialog();
      } else {
        setState(() {
          totalDurationInSeconds--;
        });
      }
    });
  }

  void showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Time's up!"),
          content: Text("The time for the quiz has run out."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsScreen(
                      totalQuestions: questions.length,
                      correctAnswers: correctAnswers,
                      incorrectAnswers: incorrectAnswers,
                    ),
                  ),
                  (route) => false,
                );
              },
              child: Text("Results"),
            ),
          ],
        );
      },
    );
  }

  void nextQuestion() {
    if (selectedOptionIndex != -1) {
      bool isCorrect = questions[currentQuestionIndex].options[selectedOptionIndex] == questions[currentQuestionIndex].answer;
      if (isCorrect) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedOptionIndex = -1;
        });
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              totalQuestions: questions.length,
              correctAnswers: correctAnswers,
              incorrectAnswers: incorrectAnswers,
            ),
          ),
          (route) => false,
        );
      }
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedOptionIndex = -1;
      });
    }
  }

  void selectOption(int index) {
    setState(() {
      selectedOptionIndex = index;
    });
  }

  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Loading indicator
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimer(),
            SizedBox(height: 20),
            _buildProgressBar(),
            SizedBox(height: 20),
            _buildQuestionText(),
            SizedBox(height: 40),
            ..._buildOptions(),
            SizedBox(height: 40),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimer() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        formatTime(totalDurationInSeconds),
        style: TextStyle(fontSize: 18, color: Colors.red),
      ),
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: (currentQuestionIndex + 1) / questions.length,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }

  Widget _buildQuestionText() {
    return Column(
      children: [
        Text(
          "Question ${currentQuestionIndex + 1} of ${questions.length}",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Text(
          questions[currentQuestionIndex].question,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<Widget> _buildOptions() {
    final double width = MediaQuery.of(context).size.width;

    return List.generate(
      questions[currentQuestionIndex].options.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          width: width * 0.8,
          child: ElevatedButton(
            onPressed: () => selectOption(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedOptionIndex == index ? Colors.green : Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              questions[currentQuestionIndex].options[index],
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: currentQuestionIndex > 0 ? previousQuestion : null,
          child: Text("Previous"),
        ),
        ElevatedButton(
          onPressed: nextQuestion,
          child: Text(currentQuestionIndex < questions.length - 1 ? "Next" : "Finish"),
        ),
      ],
    );
  }
}
