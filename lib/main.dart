import 'package:flutter/material.dart';
import 'package:travelin/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelIn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 231, 188, 71)),
        useMaterial3: true,
      ),
      home: const Mainscreen(),
    );
  }
}
