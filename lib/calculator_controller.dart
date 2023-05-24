import 'package:rxdart/rxdart.dart';

class CalculatorController {
  final _displaySubject = BehaviorSubject<String>.seeded('0');
  Stream<String> get displayStream => _displaySubject.stream;

  double _result = 0.0;
  String _currentValue = '0';
  String? _selectedOperator;
  bool _isOperatorSelected = false;
  bool _hasDecimalPoint = false;

  void inputNumber(String number) {
    if (_currentValue == '0') {
      _currentValue = number;
    } else {
      _currentValue += number;
    }
    _displaySubject.add(_currentValue);
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

      _currentValue = result.toString();
      _result = result;
      _selectedOperator = null;
      _isOperatorSelected = false;
      _hasDecimalPoint = _currentValue.contains('.');
      _displaySubject.add(_currentValue);
    }
  }

  void dispose() {
    _displaySubject.close();
  }
}