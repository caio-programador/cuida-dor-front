// providers/accessibility_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_theme.dart';

class AccessibilityProvider extends ChangeNotifier {
  double _fontSize = 1.0;
  bool _highContrast = false;

  double get fontSize => _fontSize;
  bool get highContrast => _highContrast;

  double get fontSizeMultiplier {
    return 0.8 + (_fontSize * 0.6);
  }

  AccessibilityProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _fontSize = prefs.getDouble('fontSize') ?? 0.5;
      _highContrast = prefs.getBool('highContrast') ?? false;
      notifyListeners();
    } catch (e) {
      print('Erro ao carregar preferências de acessibilidade: $e');
    }
  }

  Future<void> setFontSize(double value) async {
    _fontSize = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('fontSize', value);
    } catch (e) {
      print('Erro ao salvar tamanho da fonte: $e');
    }
  }

  Future<void> setHighContrast(bool value) async {
    _highContrast = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('highContrast', value);
    } catch (e) {
      print('Erro ao salvar contraste: $e');
    }
  }

  Color getPrimaryColor() {
    return _highContrast ? AppTheme.highContrastPrimary : AppTheme.primary;
  }

  Color getBackgroundColor() {
    return _highContrast
        ? AppTheme.highContrastBackground
        : AppTheme.background;
  }

  Color getTextColor() {
    return _highContrast ? AppTheme.highContrastText : AppTheme.textDark;
  }

  Color getSecondaryTextColor() {
    return _highContrast ? AppTheme.highContrastText : AppTheme.terciary;
  }

  Color getButtonColor() {
    return _highContrast ? AppTheme.highContrastPrimary : AppTheme.primary;
  }

  Color getIconColor() {
    return _highContrast ? AppTheme.highContrastText : AppTheme.textDark;
  }

  TextStyle applyFontSize(TextStyle baseStyle) {
    return baseStyle.copyWith(
      fontSize: (baseStyle.fontSize ?? 14) * fontSizeMultiplier,
    );
  }
}
