import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any characters that are not digits
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Format the text with spaces (4-4-5-4)
    final StringBuffer newString = StringBuffer();
    int selectionIndex = newValue.selection.end;

    for (int i = 0; i < newText.length; i++) {
      if (i == 4 || i == 8 || i == 13) {
        newString.write(' ');
        if (i < selectionIndex) {
          selectionIndex++;
        }
      }
      newString.write(newText[i]);
    }

    return TextEditingValue(
      text: newString.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
