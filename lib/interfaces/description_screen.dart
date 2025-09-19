import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Description')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'In this application, you can take quizzes on the suggested topics.\n\n'
                'Author: Permiakov Vladyslav',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
