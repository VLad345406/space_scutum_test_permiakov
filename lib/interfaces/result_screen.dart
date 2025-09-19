import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:space_scutum_test_permiakov/provider_state.dart';
import 'package:space_scutum_test_permiakov/models/question.dart';
import 'package:space_scutum_test_permiakov/interfaces/home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.questions,
    required this.countCorrectAnswers,
    required this.quizType,
    this.saveResult = true,
    required this.isPreviousDisplay,
  });

  final List<Question> questions;
  final int countCorrectAnswers;
  final String quizType;
  final bool saveResult;
  final bool isPreviousDisplay;

  void restoreQuiz() {
    for (var question in questions) {
      question.selectAnswer = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Save once after first frame (only if this is a newly finished quiz)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (saveResult) {
        Provider.of<ProviderState>(
          context,
          listen: false,
        ).addResult(quizType, questions);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        actions: [
          if (!isPreviousDisplay)
            IconButton(
              onPressed: () {
                restoreQuiz();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.home),
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: questions.length + 1, // +1 for header
        itemBuilder: (context, idx) {
          if (idx == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Text(
                    'You answered $countCorrectAnswers questions correctly!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          }

          final index = idx - 1;
          final q = questions[index];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  'Question №${index + 1}: ${q.text}',
                  textAlign: TextAlign.center,
                ),
              ),
              if (q.imageLink.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10),
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      q.imageLink,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 48),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              for (int i = 0; i < q.options.length; i++)
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: q.selectAnswer == i
                        ? (q.correctIndex == i ? Colors.green : Colors.red)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(child: Text(q.options[i])),
                    ),
                  ),
                ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(color: Colors.black),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}
