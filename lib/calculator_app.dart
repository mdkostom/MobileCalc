import 'package:flutter/material.dart';
import 'calculator_screen.dart';

// Defines the MyApp class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: CalculatorScreen(),
    );
  }
}