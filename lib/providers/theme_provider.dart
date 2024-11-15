import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_provider.g.dart';

/// Estados disponibles para el tema de la aplicación
enum ThemeState {
  /// Modo claro de la aplicación
  light,

  /// Modo oscuro de la aplicación
  dark,

  /// Modo que sigue la configuración del sistema
  system
}

/// Provider para la gestión del tema de la aplicación
///
/// Maneja el estado del tema (claro/oscuro) y proporciona
/// métodos para alternar entre los diferentes modos disponibles
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  /// Clave para almacenar la preferencia del tema en el almacenamiento local
  static const themePreferenceKey = 'theme_preference';

  /// Constructor del notificador
  ///
  /// Inicializa el tema por defecto siguiendo la configuración del sistema
  @override
  ThemeMode build() => ThemeMode.system;

  /// Alterna entre el tema claro y oscuro
  ///
  /// Si el tema actual es sistema o claro, cambia a oscuro
  /// Si el tema actual es oscuro, cambia a claro
  void toggleTheme() {
    switch (state) {
      case ThemeMode.system:
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.light;
        break;
    }
    _saveThemePreference();
  }

  /// Establece un tema específico
  ///
  /// [newTheme] El nuevo tema que se desea establecer
  void setTheme(ThemeMode newTheme) {
    state = newTheme;
    _saveThemePreference();
  }

  /// Establece el tema basado en el estado proporcionado
  ///
  /// [themeState] El estado del tema que se desea establecer
  void setThemeByState(ThemeState themeState) {
    switch (themeState) {
      case ThemeState.light:
        state = ThemeMode.light;
        break;
      case ThemeState.dark:
        state = ThemeMode.dark;
        break;
      case ThemeState.system:
        state = ThemeMode.system;
        break;
    }
    _saveThemePreference();
  }

  /// Obtiene el estado actual del tema
  ///
  /// Retorna el estado correspondiente al tema actual
  ThemeState getCurrentThemeState() {
    switch (state) {
      case ThemeMode.light:
        return ThemeState.light;
      case ThemeMode.dark:
        return ThemeState.dark;
      case ThemeMode.system:
        return ThemeState.system;
    }
  }

  /// Guarda la preferencia del tema en el almacenamiento local
  ///
  /// Este método debe implementarse usando SharedPreferences o similar
  void _saveThemePreference() {
    // TODO: Implementar guardado de preferencias
    // Ejemplo:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString(themePreferenceKey, state.toString());
  }

  /// Verifica si el tema actual es oscuro
  bool isDarkTheme() => state == ThemeMode.dark;

  /// Verifica si el tema actual es claro
  bool isLightTheme() => state == ThemeMode.light;

  /// Verifica si el tema actual sigue al sistema
  bool isSystemTheme() => state == ThemeMode.system;
}
