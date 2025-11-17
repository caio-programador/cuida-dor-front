// pages/accessibility/controller/accessibility.controller.dart
import 'package:flutter/material.dart';

class AccessibilityController extends ChangeNotifier {
  double _fontSizeValue = 0.5; // Valor do slider (0 a 1)
  bool _highContrast = false;

  double get fontSizeValue => _fontSizeValue;
  bool get highContrast => _highContrast;

  void setFontSizeValue(double value) {
    _fontSizeValue = value;
    notifyListeners();
  }

  void setHighContrast(bool value) {
    _highContrast = value;
    notifyListeners();
  }

  String getFontSizeLabel() {
    if (_fontSizeValue < 0.33) {
      return 'Pequena';
    } else if (_fontSizeValue < 0.67) {
      return 'Média';
    } else {
      return 'Grande';
    }
  }
}
