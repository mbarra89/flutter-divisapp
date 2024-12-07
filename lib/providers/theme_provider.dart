import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ThemeMode build() {
    _loadThemePreference();
    return ThemeMode.system;
  }

  /// Carga la preferencia de tema guardada
  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeIndex = prefs.getInt(themePreferenceKey);

      if (savedThemeIndex != null) {
        state = ThemeMode.values[savedThemeIndex];
      }
    } catch (e) {
      print('Error loading theme preference: $e');
    }
  }

  /// Alterna entre el tema claro y oscuro
  ///
  /// Si el tema actual es sistema o claro, cambia a oscuro
  /// Si el tema actual es oscuro, cambia a claro
  Future<void> toggleTheme() async {
    switch (state) {
      case ThemeMode.system:
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.light;
        break;
    }
    await _saveThemePreference();
  }

  /// Guarda la preferencia del tema en el almacenamiento local
  Future<void> _saveThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(themePreferenceKey, state.index);
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }

  /// Establece un tema específico
  ///
  /// [newTheme] El nuevo tema que se desea establecer
  Future<void> setTheme(ThemeMode newTheme) async {
    state = newTheme;
    await _saveThemePreference();
  }

  /// Establece el tema basado en el estado proporcionado
  ///
  /// [themeState] El estado del tema que se desea establecer
  Future<void> setThemeByState(ThemeState themeState) async {
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
    await _saveThemePreference();
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

  /// Verifica si el tema actual es oscuro
  bool isDarkTheme() => state == ThemeMode.dark;

  /// Verifica si el tema actual es claro
  bool isLightTheme() => state == ThemeMode.light;

  /// Verifica si el tema actual sigue al sistema
  bool isSystemTheme() => state == ThemeMode.system;
}
