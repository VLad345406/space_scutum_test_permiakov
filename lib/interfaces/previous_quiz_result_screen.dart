import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:space_scutum_test_permiakov/provider_state.dart';
import 'package:space_scutum_test_permiakov/models/quiz_result.dart';
import 'package:space_scutum_test_permiakov/interfaces/result_screen.dart';

class PreviousQuizResultScreen extends StatelessWidget {
  const PreviousQuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<ProviderState>().history;
    final reversedHistory = history.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous quizzes'),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear history?'),
                    content: const Text(
                      'Are you sure you want to delete all saved quiz results?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await context.read<ProviderState>().clearHistory();
                }
              },
            ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No previous results yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: reversedHistory.length,
              itemBuilder: (context, index) {
                final QuizResult result = reversedHistory[index];
                final correctAnswers = result.questions
                    .where((q) => q.selectAnswer == q.correctIndex)
                    .length;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.assignment_turned_in),
                    title: Text(
                      result.quizType,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Correct: $correctAnswers / ${result.questions.length}\n'
                      'Date: ${DateFormat('dd.MM.yyyy HH:mm').format(result.dateTime)}',
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultScreen(
                            questions: result.questions,
                            countCorrectAnswers: correctAnswers,
                            quizType: result.quizType,
                            saveResult: false,
                            isPreviousDisplay: true,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
