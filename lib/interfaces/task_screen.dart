import 'package:flutter/material.dart';
import 'package:space_scutum_test_permiakov/models/question.dart';
import 'package:space_scutum_test_permiakov/interfaces/result_screen.dart';
import 'package:space_scutum_test_permiakov/quizzes/art_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/car_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/city_quiz.dart';
import 'package:space_scutum_test_permiakov/quizzes/it_quiz.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.quizType, this.randomQuestions});

  final String quizType;
  final List<Question>? randomQuestions;

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
      'Random': widget.randomQuestions ?? [],
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
    if (!mounted) return;

    setState(() {
      selectedAnswer = value;
      questions[_quizNumber - 1].selectAnswer = value;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;

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

        if (!mounted) return;

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
    });
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  'Question №$_quizNumber:\n${q.text}',
                  key: ValueKey(_quizNumber),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22),
                ),
              ),

              const SizedBox(height: 20),
              if (q.imageLink.isNotEmpty)
                Container(
                  height: 250,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            q.imageLink,
                            fit: BoxFit.scaleDown,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  key: ValueKey(_quizNumber),
                  children: List.generate(q.options.length, (i) {
                    return RadioListTile<int>(
                      value: i,
                      groupValue: selectedAnswer,
                      onChanged: (value) => _onAnswerSelected(value!),
                      title: Text(q.options[i]),
                      activeColor: Colors.amber,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
