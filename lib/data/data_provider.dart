import 'package:flutter/material.dart';
import 'package:gpt/model/question.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


Future<List<Question>> loadQuestions() async {
    final jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((json) => Question.fromJson(json)).toList();
  }
