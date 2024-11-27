import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor =
      Color(0xFF2C6B4F); // Verde oscuro, profesional y confiable
  static const Color secondaryColor =
      Color(0xFF4D9A6B); // Verde más saturado para énfasis
  static const Color accentColor =
      Color(0xFF66C58B); // Verde brillante para elementos destacados

// Escala de grises y fondos neutrales
  static const Color backgroundColor =
      Color(0xFFF2F4F8); // Gris claro con contraste sutil
  static const Color lightBackgroundColor =
      Color(0xFFFFFFFF); // Blanco puro para máxima claridad
  static const Color darkBackgroundColor =
      Color(0xFF101317); // Negro ahumado para temas oscuros

// Superficies y texto
  static const Color lightSurfaceColor =
      Color(0xFFE6EBF1); // Gris claro con mayor contraste para fondos elevados
  static const Color darkSurfaceColor =
      Color(0xFF1A1D21); // Gris oscuro que no se mezcla con el fondo principal
  static const Color textColor =
      Color(0xFF1C1F26); // Gris oscuro muy legible para texto principal
  static const Color lightTextColor =
      Color(0xFF5A6473); // Gris medio para texto secundario
  static const Color darkTextColor =
      Color(0xFFF4F5F7); // Blanco puro para texto en temas oscuros

// Colores de estado
  static const Color errorColor =
      Color(0xFFB00020); // Rojo profesional con suficiente contraste
  static const Color successColor =
      Color(0xFF27AE60); // Verde más intenso para éxito
  static const Color warningColor =
      Color(0xFFFFB020); // Amarillo con más contraste para advertencias
  static const Color infoColor =
      Color(0xFF6C757D); // Gris suave para información

// Indicadores económicos
  static const Color upIndicatorColor =
      Color(0xFF27AE60); // Verde vibrante para indicadores en alza
  static const Color downIndicatorColor =
      Color(0xFFE74C3C); // Rojo brillante para indicadores a la baja

// Botones
  // Modo claro
  static const Color lightButtonColor =
      Color(0xFF1A6F32); // Verde oscuro elegante

// Modo oscuro
  static const Color darkButtonColor =
      Color(0xFF2C2C34); // Fondo de botón con color más oscuro y neutral

// Texto en botones
  static const Color buttonTextColor =
      Color(0xFFFFFFFF); // Blanco puro para texto en contraste

// Navegación
  // Modo claro
  static const Color lightNavBarColor =
      Color(0xFFD1D9E6); // Gris medio claro con contraste notable

// Modo oscuro
  static const Color darkNavBarColor =
      Color(0xFF1A1C23); // Gris oscuro con un tono más definido

  // Modo claro
  static const Color lightCardBackground = Color(0xFFFFFFFF); // Blanco puro
  static const Color lightCardShadow =
      Color(0x1A000000); // Negro con 10% de opacidad para sombra sutil

// Modo oscuro
  static const Color darkCardBackground =
      Color(0xFF2E3B31); // Verde oscuro neutro para el modo oscuro
  static const Color darkCardShadow =
      Color(0x66000000); // Negro con 40% de opacidad para sombra más marcada

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
