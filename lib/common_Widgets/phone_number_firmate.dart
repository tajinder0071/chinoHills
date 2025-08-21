import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formatted = '';
    if (digitsOnly.length > 0) {
      formatted += '(${digitsOnly.substring(0, digitsOnly.length.clamp(0, 3))}';
    }
    if (digitsOnly.length > 3) {
      formatted +=
          ') ${digitsOnly.substring(3, digitsOnly.length.clamp(3, 6))}';
    }
    if (digitsOnly.length > 6) {
      formatted +=
          '-${digitsOnly.substring(6, digitsOnly.length.clamp(6, 10))}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
