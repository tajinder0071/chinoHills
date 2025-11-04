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
class AllowAllCharactersFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Allow all characters, just trim extra spaces
    final trimmed = newValue.text.trim();
    return TextEditingValue(
      text: trimmed,
      selection: TextSelection.collapsed(offset: trimmed.length),
    );
  }
}

class EmailInputFormatter extends TextInputFormatter {
  static final _validEmailChars = RegExp(r'[a-zA-Z0-9@._\-+]');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final filtered = newValue.text
        .split('')
        .where((char) => _validEmailChars.hasMatch(char))
        .join();

    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}