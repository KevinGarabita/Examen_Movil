import 'package:flutter/material.dart';

/// Tema de la app. El diseño usa el estilo de Material 2: AppBar azul con
/// sombra, fondo gris claro y botones con esquinas poco redondeadas.
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final base = ThemeData(useMaterial3: false, primarySwatch: Colors.blue);
    final colorScheme = base.colorScheme.copyWith(
      // Colores del degradado del ícono de carrito.
      tertiary: Colors.deepOrange,
      tertiaryContainer: Colors.amber,
    );
    final textTheme = base.textTheme;

    return base.copyWith(
      colorScheme: colorScheme,
      appBarTheme: AppBarThemeData(
        centerTitle: true,
        titleTextStyle: base.primaryTextTheme.titleLarge,
      ),
      // En el diseño la flecha de regreso es la de iOS en todas las pantallas.
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) =>
            const Icon(Icons.arrow_back_ios_new_rounded),
      ),
      inputDecorationTheme: const InputDecorationThemeData(
        border: OutlineInputBorder(),
      ),
      textTheme: textTheme.copyWith(
        // Nombre de la tienda en el login.
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: colorScheme.primary,
        ),
        // Precio en el detalle del producto.
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
        // Nombre del producto en su detalle.
        headlineSmall: textTheme.headlineSmall?.copyWith(fontSize: 20),
        // Secciones y total del carrito.
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
