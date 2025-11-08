// lib/core/theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 52, 199, 89);
  static const Color secondary = Color.fromARGB(255, 204, 204, 204);
  static const Color terciary = Color.fromARGB(255, 64, 64, 64);
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color textDark = Color.fromARGB(255, 0, 0, 0);
  static const Color redDanger = Color.fromARGB(255, 255, 56, 60);
  static const Color backgroundLight = Color.fromARGB(255, 238, 238, 238);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textDark, fontSize: 16),
      bodyMedium: TextStyle(color: textDark, fontSize: 14),
      labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      labelStyle: const TextStyle(color: secondary),
    ),
  );
}
