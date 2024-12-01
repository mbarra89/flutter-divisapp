import 'package:flutter/material.dart';

class AppTheme {
  // Colores principales
  static const Color primaryColor =
      Color(0xFF1F4D3A); // Verde oscuro apagado y profesional
  static const Color secondaryColor =
      Color(0xFF3A7A5A); // Verde más suave para énfasis
  static const Color accentColor =
      Color(0xFF5C9D7D); // Verde tenue para elementos destacados

// Escala de grises y fondos neutrales
  static const Color backgroundColor =
      Color(0xFFECEFF1); // Gris claro más suave con menor contraste
  static const Color lightBackgroundColor =
      Color(0xFFFAFAFA); // Blanco sutil, no tan puro
  static const Color darkBackgroundColor =
      Color(0xFF181A1C); // Negro más apagado para evitar contraste extremo

// Superficies y texto
  static const Color lightSurfaceColor =
      Color(0xFFDDE2E6); // Gris claro más suave para fondos elevados
  static const Color darkSurfaceColor =
      Color(0xFF222526); // Gris oscuro suave, menos dramático
  static const Color textColor =
      Color(0xFF2B3137); // Gris oscuro neutro para texto principal
  static const Color lightTextColor =
      Color(0xFF4C565E); // Gris medio más apagado para texto secundario
  static const Color darkTextColor =
      Color(0xFFEBEBEB); // Blanco cálido, no tan puro

// Colores de estado
  static const Color errorColor =
      Color(0xFFA3333D); // Rojo sobrio y más profesional
  static const Color successColor =
      Color(0xFF219150); // Verde más discreto para éxito
  static const Color warningColor =
      Color(0xFFD48B18); // Amarillo más oscuro y menos llamativo
  static const Color infoColor =
      Color(0xFF5A6168); // Gris más oscuro para información

// Indicadores económicos
  static const Color upIndicatorColor = Color(
      0xFF219150); // Verde medio, más suave y elegante para indicar alzas.

  static const Color downIndicatorColor = Color(
      0xFFA3333D); // Rojo oscuro y sobrio para indicar bajas, más sofisticado y menos agresivo.

// Botones
// Botones en modo claro
  static const Color lightButtonColor =
      Color(0xFF0A3D62); // Azul petróleo profundo y vibrante para destacar

// Botones en modo oscuro
  static const Color darkButtonColor =
      Color(0xFF145374); // Azul petróleo más claro y brillante para contraste

// Texto en botones en ambos modos (claro/oscuro)
  static const Color buttonTextColor =
      Color(0xFFFFFFFF); // Blanco puro para máximo contraste

// Alternativa de contraste para texto en botones oscuros (solo si necesitas variar)
  static const Color buttonTextAltColor =
      Color(0xFFDAE8F1); // Azul claro pastel

// Navegación
  static const Color lightNavBarColor =
      Color(0xFFCBD4DB); // Gris claro más apagado
  static const Color darkNavBarColor =
      Color(0xFF202224); // Gris oscuro más sobrio

// Tarjetas
  // Fondo de tarjeta en modo claro
  static const Color lightCardBackground =
      Color(0xFFEAF0F2); // Azul petróleo muy claro, tenue

// Sombra para tarjetas en modo claro
  static const Color lightCardShadow =
      Color(0x1A1E2932); // Azul petróleo con baja opacidad (10%)

// Fondo de tarjeta en modo oscuro
  static const Color darkCardBackground =
      Color(0xFF1E2B2F); // Azul petróleo oscuro, sobrio

// Sombra para tarjetas en modo oscuro
  static const Color darkCardShadow =
      Color(0x660D1B23); // Azul petróleo oscuro con opacidad del 40%

// Nuevos colores para labels de ejes en gráficos
  static const Color axisLabelColorDark = Color(
      0xFFB8C6CC); // Azul petróleo muy claro para texto sobre fondo oscuro
  static const Color axisLabelColorLight =
      Color(0xFF5A7D8A); // Azul petróleo medio para texto sobre fondo claro

// Colores específicos para gráficos fl_chart
  static const Color lineChartPrimaryColor =
      Color(0xFF1F4D3A); // Línea principal más sobria
  static const Color lineChartSecondaryColor =
      Color(0xFF3A7A5A); // Línea secundaria más suave
  static const Color lineChartFillColor =
      Color(0x335C9D7D); // Relleno verde suave con menor opacidad
  static const Color lineChartGridColor =
      Color(0xFFB0BEC5); // Gris claro suave para líneas de cuadrícula
  static const Color lineChartAxisColor =
      Color(0xFF4C565E); // Gris medio apagado para los ejes
  static const Color lineChartHighlightColor =
      Color(0xFFA3333D); // Rojo sobrio para resaltar puntos importantes

  static const Color barChartPositiveColor =
      Color(0xFF219150); // Verde sobrio para barras positivas
  static const Color barChartNegativeColor =
      Color(0xFFA3333D); // Rojo suave para barras negativas
  static const Color barChartBackgroundColor =
      Color(0xFFECEFF1); // Fondo del gráfico más neutro
  static const Color pieChartSectionColor1 =
      Color(0xFF5C9D7D); // Verde suave para sección 1
  static const Color pieChartSectionColor2 =
      Color(0xFF3A7A5A); // Verde medio para sección 2
  static const Color pieChartSectionColor3 =
      Color(0xFF1F4D3A); // Verde oscuro para sección 3
  static const Color pieChartSectionColor4 =
      Color(0xFFD48B18); // Amarillo sobrio para sección 4

  static const Color axisLabelColorWhite = Color(0xFFECEFF1); // Blanco cálido

  static const Color accentOrangeColor = Color(
      0xFFF5A623); // Naranja suave para destacar cambios moderados o alertas suaves.

  static const Color accentGoldColor = Color(
      0xFFFFD700); // Dorado elegante para acciones importantes o elementos destacados.

  static const Color positiveChangeColor = Color(
      0xFF21CE99); // Verde vibrante para indicar cambios positivos o crecimiento económico.

  static const Color neutralTextColor = Color(
      0xFFB0BEC5); // Gris suave para texto informativo o valores secundarios.

  static const Color backgroundDarkColor = Color(
      0xFF1E1E1E); // Fondo oscuro para mantener la elegancia y enfoque en los datos.

  static const Color buttonHighlightColor = Color(
      0xFF0A84FF); // Azul claro para botones secundarios, como "Volver" o "Actualizar".

  static const Color lightButtonTextColor = Color(
      0xFFFFFFFF); // Blanco para texto en botones principales, asegura alta legibilidad.

  static const Color accentButtonTextColor = Color(
      0xFF1E1E1E); // Gris oscuro para texto en botones secundarios, ofreciendo un buen contraste sin ser tan fuerte como el blanco.

  static const Color actionButtonTextColor = Color(
      0xFFFFFFFF); // Blanco para el texto de botones de acción importantes (como "Descargar reporte"), destacando sobre el dorado o naranja.

  static const Color disabledButtonTextColor = Color(
      0xFF9E9E9E); // Gris claro para botones deshabilitados, indicando que no se puede interactuar con ellos.

  static const Color alertButtonTextColor = Color(
      0xFFFFFFFF); // Blanco para texto en botones de alerta o críticos, usando un fondo cálido como naranja para llamar la atención rápidamente.

  static const Color iconBackgroundColor = Color(
      0xFF3A3A40); // Fondo oscuro y sutil para los iconos, proporciona un contraste elegante sin ser demasiado brillante.

  static const Color appBarBackgroundColor = Color(
      0xFF212126); // Fondo oscuro para la barra de navegación, manteniendo la coherencia con el resto de la interfaz.

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
