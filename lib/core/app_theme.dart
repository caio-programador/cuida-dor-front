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

  // Cores de alto contraste
  static const Color highContrastPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color highContrastText = Color.fromARGB(255, 0, 0, 0);
  static const Color highContrastBackground = Color.fromARGB(
    255,
    255,
    255,
    255,
  );

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

  static ThemeData highContrastTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: highContrastBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: highContrastPrimary,
      primary: highContrastPrimary,
      secondary: Colors.grey[800]!,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: highContrastBackground,
      foregroundColor: highContrastText,
      elevation: 1,
      iconTheme: IconThemeData(color: highContrastText),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: highContrastText,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: highContrastText,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        color: highContrastBackground,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: highContrastPrimary,
        foregroundColor: highContrastBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 3),
      ),
      labelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    ),
    iconTheme: const IconThemeData(color: highContrastText),
    dividerColor: Colors.black,
  );
}
