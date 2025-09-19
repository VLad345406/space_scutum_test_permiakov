import 'question.dart';

class QuizResult {
  final String quizType;
  final DateTime dateTime;
  final List<Question> questions;

  QuizResult({
    required this.quizType,
    required this.dateTime,
    required this.questions,
  });

  Map<String, dynamic> toJson() => {
    'quizType': quizType,
    'dateTime': dateTime.toIso8601String(),
    'questions': questions.map((q) => q.toJson()).toList(),
  };

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
    quizType: json['quizType'] as String,
    dateTime: DateTime.parse(json['dateTime'] as String),
    questions: (json['questions'] as List)
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
