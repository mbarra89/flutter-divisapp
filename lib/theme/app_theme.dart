import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color secondaryColor = Color(0xFF303F9F);
  static const Color accentColor = Color(0xFF3949AB);

  static const Color backgroundColor = Color(0xFFF8F9FC);
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF121212);

  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);

  static const Color textColor = Color(0xFF1A1A1A);
  static const Color lightTextColor = Color(0xFF2C2C2C);
  static const Color darkTextColor = Color(0xFFF5F5F5);

  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color infoColor = Color(0xFF1976D2);

  static const Color lightButtonColor = Color(0xFF1A237E);
  static const Color darkButtonColor = Color(0xFF3949AB);
  static const Color buttonTextColor = Color(0xFFFFFFFF);

  static ThemeData lightTheme() {
    return _buildTheme(Brightness.light);
  }

  static ThemeData darkTheme() {
    return _buildTheme(Brightness.dark);
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final baseTheme =
        brightness == Brightness.light ? ThemeData.light() : ThemeData.dark();

    return baseTheme.copyWith(
      scaffoldBackgroundColor: brightness == Brightness.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 20.0),
        bodyMedium: TextStyle(fontSize: 16.0),
        bodySmall: TextStyle(fontSize: 12.0),
      ).apply(
        bodyColor:
            brightness == Brightness.light ? lightTextColor : darkTextColor,
        displayColor:
            brightness == Brightness.light ? lightTextColor : darkTextColor,
      ),
      colorScheme:
          ColorScheme.fromSeed(seedColor: primaryColor, brightness: brightness)
              .copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            brightness == Brightness.light ? lightButtonColor : darkButtonColor,
          ),
          foregroundColor: WidgetStateProperty.all(buttonTextColor),
          textStyle: WidgetStateProperty.all(const TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}
