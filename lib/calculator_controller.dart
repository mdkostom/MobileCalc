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
  String? _selectedOperator;
  bool _isOperatorSelected = false;
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
    if (_currentValue != '0' && !_isOperatorSelected) {
      String displayValue = _displaySubject.value;
      if (displayValue.endsWith(' ') || displayValue.endsWith('0')) {
        displayValue = displayValue.substring(0, displayValue.length - 1);
      }
      displayValue += ' $operator ';
      _displaySubject.add(displayValue);

      _result = double.parse(_currentValue);
      _currentValue = '0';
      _selectedOperator = operator;
      _isOperatorSelected = true;
      _hasDecimalPoint = false;
    }
  }

  void calculateResult() {
    if (_selectedOperator != null && _isOperatorSelected) {
      final double currentValue = double.parse(_currentValue);
      double result = 0.0;

      switch (_selectedOperator) {
        case '+':
          result = _result + currentValue;
          break;
        case '-':
          result = _result - currentValue;
          break;
        case '*':
          result = _result * currentValue;
          break;
        case '/':
          result = _result / currentValue;
          break;
      }

      final String expression = '$_result $_selectedOperator $currentValue';
      _currentValue = result.toString();
      if (result % 1 == 0) {
        _currentValue = result.toInt().toString();
      } else {
        _currentValue = result.toStringAsFixed(2);
      }

      _result = result;
      _selectedOperator = null;
      _isOperatorSelected = false;
      _hasDecimalPoint = _currentValue.contains('.');
      _displaySubject.add('$expression = $_currentValue');

      _recordCalculation();
    }
  }



  void clear() {
    _currentValue = '0';
    _selectedOperator = null;
    _isOperatorSelected = false;
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
