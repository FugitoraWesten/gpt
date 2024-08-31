import 'package:flutter/material.dart';

import 'package:gpt/screens/question_screen.dart';
import 'package:gpt/screens/progress_screen.dart';

class WelcomeBanner extends StatelessWidget {
  final String userName;

  const WelcomeBanner({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, $userName!',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              '“The best preparation for tomorrow is doing your best today.”',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressOverview extends StatelessWidget {
  final double progressValue;

  const ProgressOverview({required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: progressValue,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProgressScreen(
                  totalQuestions: 0,
                  correctAnswers: 0,
                  incorrectAnswers: 0,
                ),
                ),
              );
              },
              child: Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyChallengeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: ListTile(
        title: Text('Daily Challenge'),
        subtitle: Text('Complete today’s challenge to boost your skills!'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => 
          //       ),
          //     );
        },
      ),
    );
  }
}
