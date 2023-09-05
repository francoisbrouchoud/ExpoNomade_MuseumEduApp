import 'package:flutter/services.dart';

/// Class IntegerInputFormatter is a formatter for TextInputFields that authorizes only integers (positive and negative) to be input.
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

/// Class DecimalInputFormatter is a formatter for TextInputFields that authorizes only positive decimals to be input.
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
