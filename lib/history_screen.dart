import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calculator_controller.dart';

class HistoryScreen extends StatelessWidget {
  final CalculatorController controller;

  HistoryScreen({required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<CalculationEntry> history = controller.getHistory();

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Clear History'),
                  content: Text('Are you sure you want to clear the history?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Clear'),
                      onPressed: () {
                        controller.clearHistory();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final entry = history[index];
          return ListTile(
            title: Text(entry.calculation),
            subtitle: Text(entry.timestamp.toString()),
          );
        },
      ),
    );
  }
}
