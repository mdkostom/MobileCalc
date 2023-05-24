import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'converter_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CalculatorScreen(),
        '/converter': (context) => ConverterScreen(),
      },
    );
  }
}