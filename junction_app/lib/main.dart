import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: JunctionApp()));
}

class JunctionApp extends StatelessWidget {
  const JunctionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Junction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFBB86FC),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'THE JUNCTION',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
      ),
    );
  }
}