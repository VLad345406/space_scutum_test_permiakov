import 'package:flutter/material.dart';
import 'package:space_scutum_test_permiakov/elements/quiz_button.dart';
import 'package:space_scutum_test_permiakov/interfaces/previous_quiz_result_screen.dart';
import 'package:space_scutum_test_permiakov/interfaces/description_screen.dart';
import 'package:space_scutum_test_permiakov/interfaces/select_quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz application')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuizButton(
            buttonText: 'Start',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectQuizScreen()),
              );
            },
          ),
          SizedBox(height: 15),
          QuizButton(
            buttonText: 'Description',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DescriptionScreen()),
              );
            },
          ),
          SizedBox(height: 15),
          QuizButton(
            buttonText: 'Previous quiz',
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreviousQuizResultScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
