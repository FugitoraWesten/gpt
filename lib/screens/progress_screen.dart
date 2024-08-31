import 'package:flutter/material.dart';
import '../model/read_file.dart';

class ProgressScreen extends StatefulWidget {
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;

  ProgressScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
  });

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<Map<String, dynamic>> _dataList = [];
  final FileReader _fileReader = FileReader();

  @override
  void initState() {
    super.initState();
    loadData(); 
  }

  void loadData() async {
    _dataList = await _fileReader.readJsonFromFile('quiz_results');
    setState(() {
      // Trigger a rebuild to show the loaded data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _dataList.isNotEmpty
                  ? ListView.builder(
                      itemCount: _dataList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text('Total Questions: ${_dataList[index]['totalQuestions']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Correct Answers: ${_dataList[index]['correctAnswers']}'),
                                Text('Incorrect Answers: ${_dataList[index]['incorrectAnswers']}'),
                                Text('Timestamp: ${_dataList[index]['timestamp']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(child: Text('No data available')),
            ),
          ],
        ),
      ),
    );
  }
}
