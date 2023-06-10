import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'converter_screen.dart';
import 'history_screen.dart';
import 'calculator_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CalculatorController calculatorController = CalculatorController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CalculatorScreen(controller: calculatorController),
        '/converter': (context) => ConverterScreen(),
        '/history': (context) => HistoryScreen(controller: calculatorController),
      },
    );
  }
}
