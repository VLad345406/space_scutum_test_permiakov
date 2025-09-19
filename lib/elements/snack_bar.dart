import 'package:flutter/material.dart';

void snackBar(BuildContext context, String messageText) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        messageText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      backgroundColor: Colors.amber,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: const Duration(seconds: 2),
    ),
  );
}
