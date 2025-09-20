import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:space_scutum_test_permiakov/provider_state.dart';
import 'package:space_scutum_test_permiakov/interfaces/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final provider = ProviderState();
  await provider.loadHistory();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber,
          centerTitle: true,
          titleTextStyle: GoogleFonts.aBeeZee(
            fontSize: 30,
            color: Colors.black,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: _CustomPageTransitionBuilder(),
            TargetPlatform.iOS: _CustomPageTransitionBuilder(),
          },
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class _CustomPageTransitionBuilder extends PageTransitionsBuilder {
  const _CustomPageTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }
}
