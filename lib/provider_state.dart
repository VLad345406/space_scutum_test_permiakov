import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/quiz_result.dart';
import 'models/question.dart';

class ProviderState with ChangeNotifier {
  final List<QuizResult> _history = [];
  List<QuizResult> get history => List.unmodifiable(_history);

  // Call once on app start
  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('quiz_history') ?? [];

    _history.clear();
    _history.addAll(data.map((e) => QuizResult.fromJson(jsonDecode(e))));
    notifyListeners();
  }

  // Add result. Make deep copy of questions so later changes don't mutate saved result.
  Future<void> addResult(String quizType, List<Question> questions) async {
    final copiedQuestions = questions.map((q) => q.copy()).toList();

    final result = QuizResult(
      quizType: quizType,
      dateTime: DateTime.now(),
      questions: copiedQuestions,
    );
    _history.add(result);

    final prefs = await SharedPreferences.getInstance();
    final data = _history.map((r) => jsonEncode(r.toJson())).toList();
    await prefs.setStringList('quiz_history', data);

    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quiz_history');
    notifyListeners();
  }
}
