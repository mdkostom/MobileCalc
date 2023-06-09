import 'package:flutter/material.dart';
import 'calculator_controller.dart';

class CalculatorScreen extends StatefulWidget {
  final CalculatorController controller;

  CalculatorScreen({required this.controller});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.initPreferences();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<String>(
              stream: widget.controller.displayStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(fontSize: 36.0),
                  );
                } else {
                  return Text(
                    'Error',
                    style: TextStyle(fontSize: 36.0),
                  );
                }
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                _buildOperatorButton('+'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                _buildOperatorButton('-'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                _buildOperatorButton('*'),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('0'),
                _buildDecimalButton(),
                _buildOperatorButton('/'),
                _buildClearButton(),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: widget.controller.calculateResult,
                  child: Text('='),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/converter');
                  },
                  child: Text('Kilometer To Mile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  child: Text('History'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => widget.controller.inputNumber(number),
      child: Text(number),
    );
  }

  Widget _buildDecimalButton() {
    return ElevatedButton(
      onPressed: widget.controller.inputDecimal,
      child: Text('.'),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return ElevatedButton(
      onPressed: () => widget.controller.selectOperator(operator),
      child: Text(operator),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: () => widget.controller.clear(),
      child: Text('C'),
    );
  }
}
