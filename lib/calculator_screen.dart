import 'package:flutter/material.dart';

// Contains the Calculator widget
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
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
            Text(
              '0',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('7'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('8'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('9'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('+'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('4'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('5'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('6'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('-'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('1'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('2'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('3'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('*'),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text('0'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('.'),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('='),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('/'),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}