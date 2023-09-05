import 'package:flutter/services.dart';

class IntegerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^[+-]?[0-9]*$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'^\d+\.?\d*$');
    if (!regExp.hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}
