import 'package:flutter/material.dart';
import 'calculator_controller.dart';

// Contains the Calculator widget
class CalculatorScreen extends StatelessWidget {
  final CalculatorController _controller = CalculatorController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<String>(
              stream: _controller.displayStream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? '0',
                  style: TextStyle(fontSize: 48.0),
                );
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('7'),
                  onPressed: () => _controller.inputNumber('7'),
                ),
                ElevatedButton(
                  child: Text('8'),
                  onPressed: () => _controller.inputNumber('8'),
                ),
                ElevatedButton(
                  child: Text('9'),
                  onPressed: () => _controller.inputNumber('9'),
                ),
                ElevatedButton(
                  child: Text('+'),
                  onPressed: () => _controller.selectOperator('+'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('4'),
                  onPressed: () => _controller.inputNumber('4'),
                ),
                ElevatedButton(
                  child: Text('5'),
                  onPressed: () => _controller.inputNumber('5'),
                ),
                ElevatedButton(
                  child: Text('6'),
                  onPressed: () => _controller.inputNumber('6'),
                ),
                ElevatedButton(
                  child: Text('-'),
                  onPressed: () => _controller.selectOperator('-'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('1'),
                  onPressed: () => _controller.inputNumber('1'),
                ),
                ElevatedButton(
                  child: Text('2'),
                  onPressed: () => _controller.inputNumber('2'),
                ),
                ElevatedButton(
                  child: Text('3'),
                  onPressed: () => _controller.inputNumber('3'),
                ),
                ElevatedButton(
                  child: Text('*'),
                  onPressed: () => _controller.selectOperator('*'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('0'),
                  onPressed: () => _controller.inputNumber('0'),
                ),
                ElevatedButton(
                  child: Text('.'),
                  onPressed: () => _controller.inputDecimal(),
                ),
                ElevatedButton(
                  child: Text('='),
                  onPressed: () => _controller.calculateResult(),
                ),
                ElevatedButton(
                  child: Text('/'),
                  onPressed: () => _controller.selectOperator('/'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
