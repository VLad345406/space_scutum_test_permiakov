// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:space_scutum_test_permiakov/provider_state.dart';
import 'package:space_scutum_test_permiakov/interfaces/home_screen.dart'; // твой стартовый экран

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final provider = ProviderState();
  await provider.loadHistory(); // загружаем историю перед runApp

  runApp(
    ChangeNotifierProvider(
      create: (_) => provider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
          titleTextStyle: GoogleFonts.aBeeZee(
            fontSize: 30,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_scutum_test_permiakov/interfaces/home_screen.dart';
import 'package:space_scutum_test_permiakov/provider_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final quizHistoryProvider = ProviderState();
  await quizHistoryProvider.loadHistory();

  runApp(
    ChangeNotifierProvider(
      create: (_) => quizHistoryProvider,
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
          titleTextStyle: GoogleFonts.aBeeZee(
            fontSize: 30,
            color: Colors.black,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
        ),
      ),
      home: HomeScreen(),
    );
  }
}*/
