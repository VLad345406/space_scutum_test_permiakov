import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizButton extends StatelessWidget {
  final String buttonText;
  final Function() function;

  const QuizButton({
    super.key,
    required this.buttonText,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.amber),
        ),
        onPressed: function,
        child: Container(
          constraints: BoxConstraints(
            minWidth: 160,
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
