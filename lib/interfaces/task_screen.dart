import 'package:flutter/material.dart';
import 'package:space_scutum_test_permiakov/models/question.dart';
import 'package:space_scutum_test_permiakov/quizzes/art_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/car_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/city_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/it_quiz.dart';
import 'package:space_scutum_test_permiakov/interfaces/result_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.quizType});

  final String quizType;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int _quizNumber = 1;
  int? selectedAnswer;
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();

    final Map<String, List<Question>> sourceMap = {
      'Art': artQuestions,
      'Car': carQuestions,
      'City': cityQuestions,
      'IT': itQuestions,
    };

    final source = sourceMap[widget.quizType] ?? [];

    questions = source.map((q) {
      return Question(
        text: q.text,
        options: List<String>.from(q.options),
        correctIndex: q.correctIndex,
        imageLink: q.imageLink,
        selectAnswer: -1,
      );
    }).toList();
  }

  void _onAnswerSelected(int value) {
    setState(() {
      selectedAnswer = value;
      questions[_quizNumber - 1].selectAnswer = value;
    });
    if (_quizNumber < questions.length) {
      setState(() {
        _quizNumber++;
        selectedAnswer = questions[_quizNumber - 1].selectAnswer >= 0
            ? questions[_quizNumber - 1].selectAnswer
            : null;
      });
    } else {
      final correct = questions
          .where((q) => q.selectAnswer == q.correctIndex)
          .length;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            questions: questions,
            countCorrectAnswers: correct,
            quizType: widget.quizType,
            saveResult: true,
            isPreviousDisplay: false,
          ),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.quizType} quiz')),
        body: const Center(child: Text('No questions for this quiz')),
      );
    }

    final q = questions[_quizNumber - 1];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.quizType} quiz')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                'Question №$_quizNumber:\n${q.text}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (q.imageLink.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(maxHeight: 300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  q.imageLink,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
          ...List.generate(q.options.length, (i) {
            return RadioListTile<int>(
              value: i,
              groupValue: selectedAnswer,
              onChanged: (value) => _onAnswerSelected(value!),
              title: Text(q.options[i]),
              activeColor: Colors.amber,
            );
          }),
        ],
      ),
    );
  }
}
