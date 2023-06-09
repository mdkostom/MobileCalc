import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  TextEditingController _kilometerController = TextEditingController();
  TextEditingController _mileController = TextEditingController();

  void convertKilometerToMile() {
    double kilometer = double.tryParse(_kilometerController.text) ?? 0.0;
    double mile = kilometer * 0.621371;
    _mileController.text = mile.toStringAsFixed(2);
  }

  void convertMileToKilometer() {
    double mile = double.tryParse(_mileController.text) ?? 0.0;
    double kilometer = mile * 1.60934;
    _kilometerController.text = kilometer.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kilometer to Mile Converter'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kilometerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kilometer',
              ),
            ),
            ElevatedButton(
              child: Text('Convert to Mile'),
              onPressed: convertKilometerToMile,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _mileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Mile',
              ),
            ),
            ElevatedButton(
              child: Text('Convert to Kilometer'),
              onPressed: convertMileToKilometer,
            ),
          ],
        ),
      ),
    );
  }
}
