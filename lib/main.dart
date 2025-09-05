// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Collective Waste',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
