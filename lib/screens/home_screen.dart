import 'package:flutter/material.dart';
import '../components/components.dart'; // Import your shared components

class HomeScreen extends StatelessWidget {
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
            _buildQuickStartSection(context),
            SizedBox(height: 20),
            ProgressOverview(progressValue: 0.7),
            SizedBox(height: 20),
            _buildPracticeHistory(context),
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
              // Navigate to Level Selector Screen
            },
            child: Text('Start Quiz'),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Continue Last Quiz Screen
            },
            child: Text('Continue Last Quiz'),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Quizzes',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Quiz ${index + 1}'),
              subtitle: Text('Date: 2024-08-27, Score: 80%'),
              onTap: () {
                // Navigate to Progress Detail Screen
              },
            );
          },
        ),
      ],
    );
  }
}
