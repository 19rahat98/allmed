import 'package:flutter/services.dart';

class CapitalizeWordsTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    final words = text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return newValue.copyWith(
      text: words,
      selection: newValue.selection,
    );
  }
}
