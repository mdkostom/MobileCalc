import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculationEntry {
  final String calculation;
  final DateTime timestamp;

  CalculationEntry({
    required this.calculation,
    required this.timestamp,
  });
}

class CalculatorController {
  final _displaySubject = BehaviorSubject<String>.seeded('0');
  Stream<String> get displayStream => _displaySubject.stream;

  double _result = 0.0;
  String _currentValue = '0';
  String _expression = '';
  bool _hasDecimalPoint = false;
  List<CalculationEntry> _history = [];
  late SharedPreferences _preferences;

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadHistory();
  }

  void _loadHistory() {
    final historyJson = _preferences.getString('history');
    if (historyJson != null) {
      final List<dynamic> historyList = jsonDecode(historyJson);
      _history = historyList
          .map((entry) => CalculationEntry(
        calculation: entry['calculation'],
        timestamp: DateTime.parse(entry['timestamp']),
      ))
          .toList();
    }
  }

  void _saveHistory() {
    final List<Map<String, dynamic>> historyList = _history.map((entry) {
      return {
        'calculation': entry.calculation,
        'timestamp': entry.timestamp.toIso8601String(),
      };
    }).toList();
    final historyJson = jsonEncode(historyList);
    _preferences.setString('history', historyJson);
  }

  void inputNumber(String number) {
    if (_currentValue == '0') {
      _currentValue = number;
    } else {
      _currentValue += number;
    }

    String displayValue = _displaySubject.value;
    if (displayValue == '0') {
      displayValue = '';
    }
    displayValue += number;
    _displaySubject.add(displayValue);
  }

  void inputDecimal() {
    if (!_hasDecimalPoint) {
      _currentValue += '.';
      _hasDecimalPoint = true;
      _displaySubject.add(_currentValue);
    }
  }

  void selectOperator(String operator) {
    if (_currentValue != '0') {
      String displayValue = _displaySubject.value;
      displayValue += ' $operator ';
      _expression += '$_currentValue $operator ';
      _currentValue = '0';
      _hasDecimalPoint = false;
      _displaySubject.add(displayValue);
    }
  }

  void calculateResult() {
    if (_expression.isNotEmpty && _currentValue != '0') {
      final double currentValue = double.parse(_currentValue);
      _expression += '$_currentValue';
      final double result = _calculateExpression(_expression);

      _currentValue = result.toString();
      if (result % 1 == 0) {
        _currentValue = result.toInt().toString();
      } else {
        _currentValue = result.toStringAsFixed(2);
      }

      _result = result;
      _hasDecimalPoint = _currentValue.contains('.');
      _displaySubject.add('$_expression = $_currentValue');

      _recordCalculation();
      _expression = '';
    }
  }

  double _calculateExpression(String expression) {
    final parts = expression.split(' ');

    // Evaluate multiplication and division first
    for (var i = 0; i < parts.length; i++) {
      if (parts[i] == '*' || parts[i] == '/') {
        final num1 = double.parse(parts[i - 1]);
        final num2 = double.parse(parts[i + 1]);
        double result;

        if (parts[i] == '*') {
          result = num1 * num2;
        } else {
          result = num1 / num2;
        }

        parts.replaceRange(i - 1, i + 2, [result.toString()]);
        i--;
      }
    }

    // Evaluate addition and subtraction
    double result = double.parse(parts[0]);
    for (var i = 1; i < parts.length; i += 2) {
      final operator = parts[i];
      final operand = double.parse(parts[i + 1]);

      if (operator == '+') {
        result += operand;
      } else {
        result -= operand;
      }
    }

    return result;
  }


  void clear() {
    _currentValue = '0';
    _hasDecimalPoint = false;
    _displaySubject.add(_currentValue);
  }

  void _recordCalculation() {
    final String expression = '${_displaySubject.value}';
    final entry = CalculationEntry(
      calculation: expression,
      timestamp: DateTime.now(),
    );
    _history.insert(0, entry);
    _saveHistory();
  }

  List<CalculationEntry> getHistory() {
    return List.from(_history);
  }

  void clearHistory() {
    _history.clear();
    _saveHistory();
  }

  void dispose() {
    _displaySubject.close();
  }
}
