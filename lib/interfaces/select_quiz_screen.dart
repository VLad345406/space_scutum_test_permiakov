import 'package:flutter/material.dart';
import 'task_screen.dart';

class SelectQuizScreen extends StatelessWidget {
  SelectQuizScreen({super.key});

  final List<Map<String, String>> quizOptions = [
    {'title': 'Art', 'icon': 'assets/icons/art.png'},
    {'title': 'Car', 'icon': 'assets/icons/car.png'},
    {'title': 'City', 'icon': 'assets/icons/city.png'},
    {'title': 'IT', 'icon': 'assets/icons/it.png'},
    {'title': 'Random', 'icon': 'assets/icons/random.png'},
  ];

  void _onQuizTap(BuildContext context, String title) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TaskScreen(quizType: title)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select quiz')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: quizOptions.length,
        itemBuilder: (context, index) {
          final option = quizOptions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _onQuizTap(context, option['title']!),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Image.asset(option['icon']!, width: 80, height: 80),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option['title']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
