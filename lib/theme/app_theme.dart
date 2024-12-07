import 'package:flutter/material.dart';

class AppTheme {
  // Colores para TextFormField en modo oscuro
  static const Color darkTextColor =
      Color(0xFFE0E0E0); // Blanco cálido para texto
  static const Color darkBorderColor =
      Color(0xFF4C565E); // Gris oscuro para borde
  static const Color darkFocusColor =
      Color(0xFF4CAF50); // Verde brillante para foco
  static const Color darkIconColor =
      Color(0xFF757575); // Gris suave para iconos
  static const Color darkErrorColor =
      Color(0xFFD32F2F); // Rojo brillante para error
  static const Color darkLabelColor =
      Color(0xFFB0BEC5); // Gris claro para label

  // Colores para TextFormField en modo claro
  static const Color lightTextColor =
      Color(0xFF212121); // Gris oscuro para texto
  static const Color lightBorderColor =
      Color(0xFFB0BEC5); // Gris suave para borde
  static const Color lightFocusColor =
      Color(0xFF82CBB7); // Verde más brillante para foco
  static const Color lightIconColor =
      Color(0xFF5A7D8A); // Gris medio para iconos
  static const Color lightErrorColor =
      Color(0xFFD32F2F); // Rojo brillante para error
  static const Color lightLabelColor =
      Color(0xFF5A7D8A); // Gris medio para label

  // Método para crear InputDecoration
  static InputDecoration inputDecoration(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    return InputDecoration(
      filled: true,
      fillColor: isDark
          ? const Color(0xFF222526)
          : Colors.white, // Fondo del TextFormField
      hintText: "Ingrese su dato", // Placeholder
      hintStyle: TextStyle(
        color: isDark ? darkTextColor : lightTextColor, // Color del placeholder
      ),
      labelText: "Campo",
      labelStyle: TextStyle(
        color:
            isDark ? darkLabelColor : lightLabelColor, // Color de la etiqueta
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? darkBorderColor : lightBorderColor, // Borde normal
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isDark ? darkFocusColor : lightFocusColor, // Borde con foco
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: darkErrorColor, // Borde en caso de error
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: darkErrorColor, // Borde en caso de error con foco
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      prefixIcon: Icon(
        Icons.input, // Icono del campo
        color: isDark ? darkIconColor : lightIconColor, // Color del icono
      ),
    );
  }

  // Colores de texto para el título
  static const Color darkTitleTextColor =
      Color(0xFFE0E0E0); // Blanco cálido para título en modo oscuro
  static const Color lightTitleTextColor =
      Color(0xFF212121); // Gris oscuro para título en modo claro

// Colores principales
  static const Color primaryColor =
      Color(0xFF4C9A7D); // Verde más brillante y visible en fondo oscuro
  static const Color secondaryColor =
      Color(0xFF5FB88C); // Verde más suave pero más visible
  static const Color accentColor =
      Color(0xFF82CBB7); // Verde más claro para detalles y énfasis

// Escala de grises y fondos neutrales
  static const Color backgroundColor =
      Color(0xFF121212); // Fondo más oscuro para mejor contraste
  static const Color lightBackgroundColor =
      Color(0xFFFFFFFF); // Fondo blanco para modo claro
  static const Color darkBackgroundColor =
      Color(0xFF181A1C); // Fondo de tono neutro muy oscuro

// Superficies y texto
  static const Color lightSurfaceColor =
      Color(0xFFF5F5F5); // Gris claro para fondos elevados en modo claro
  static const Color darkSurfaceColor = Color(
      0xFF222526); // Gris suave con poco contraste para superficies oscuras
  static const Color textColor = Color(
      0xFF212121); // Gris oscuro neutro para texto principal en modo claro

// Colores de estado
  static const Color errorColor =
      Color(0xFFD32F2F); // Rojo vibrante, más visible y profesional
  static const Color successColor =
      Color(0xFF388E3C); // Verde más brillante para indicar éxito
  static const Color warningColor =
      Color(0xFFFBC02D); // Amarillo más brillante para advertencias
  static const Color infoColor =
      Color(0xFF0288D1); // Azul más brillante para información

// Indicadores económicos
  static const Color upIndicatorColor =
      Color(0xFF4CAF50); // Verde medio brillante para indicar alzas

  static const Color downIndicatorColor =
      Color(0xFFD32F2F); // Rojo brillante para indicar bajas

// Botones
// Botones en modo oscuro
  static const Color darkButtonColor =
      Color(0xFF4CAF50); // Verde más brillante para destacar en fondo oscuro

// Botones en modo claro
  static const Color lightButtonColor =
      Color(0xFF82CBB7); // Verde más claro para destacar en fondo claro

// Texto en botones
  static const Color buttonTextColor =
      Color(0xFFFFFFFF); // Blanco puro para máximo contraste

// Navegación
  static const Color darkNavBarColor =
      Color(0xFF121212); // Fondo oscuro para la barra de navegación
  static const Color lightNavBarColor = Color(
      0xFFFAFAFA); // Fondo claro para la barra de navegación en modo claro

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

  static const Color errorMessageColor = Color(0xFFFF6F61); // Un rojo suave

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
      appBarTheme: AppBarTheme(
        backgroundColor:
            brightness == Brightness.light ? lightNavBarColor : darkNavBarColor,
      ),
    );
  }
}
