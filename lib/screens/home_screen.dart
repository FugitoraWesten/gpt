import 'package:flutter/material.dart';
import 'package:gpt/screens/level_selector_screen.dart';
import 'package:gpt/screens/progress_screen.dart';
import 'package:gpt/screens/question_screen.dart';
import '../components/components.dart';
import '../model/read_file.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _recentQuizzes = [];
  final FileReader _fileReader = FileReader();

  @override
  void initState() {
    super.initState();
    _loadRecentQuizzes();
  }

  Future<void> _loadRecentQuizzes() async {
    _recentQuizzes = await _fileReader.readJsonFromFile('recent_quizzes');
    setState(() {}); // Refresh the UI with the loaded data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAT Prep'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeBanner(userName: '[User Name]'),
            SizedBox(height: 20),
            ProgressOverview(progressValue: 0.7),
            SizedBox(height: 20),
            _buildQuickStartSection(context),
            SizedBox(height: 20),
            _buildRecentQuizzes(context),
            SizedBox(height: 20),
            DailyChallengeCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionsScreen(
                    level: 'beginner',
                    jsonFilePath: Jsonpath.beginner,
                  ),
                ),
              );
            },
            child: Text('Start Quiz'),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LevelSelectorScreen(),
                ),
              );
            },
            child: Text('Continue Last Quiz'),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentQuizzes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Quizzes',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8),
        _recentQuizzes.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _recentQuizzes.length,
                itemBuilder: (context, index) {
                  final quiz = _recentQuizzes[index];
                  return ListTile(
                    title: Text('Quiz ${index + 1}'),
                    subtitle: Text('Date: ${quiz['date']}, Score: ${quiz['score']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgressScreen(
                            totalQuestions: quiz['totalQuestions'],
                            correctAnswers: quiz['correctAnswers'],
                            incorrectAnswers: quiz['incorrectAnswers'],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Center(child: Text('No recent quizzes available')),
      ],
    );
  }
}
