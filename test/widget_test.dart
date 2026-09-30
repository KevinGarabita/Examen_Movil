import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:examen_movil/main.dart';
import 'package:examen_movil/screens/home_screen.dart';
import 'package:examen_movil/theme/app_theme.dart';

import 'fake_api.dart';

Future<void> pumpHome(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
  );
  await tester.pumpAndSettle();
}

Future<void> login(
  WidgetTester tester,
  String username,
  String password,
) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Usuario / Correo'),
    username,
  );
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Contraseña'),
    password,
  );
  await tester.tap(find.text('Aceptar'));
  await tester.pumpAndSettle();
}

void main() {
  // Sin esto, una prueba recibe lecturas de JSON en caché que empezaron en la
  // prueba anterior y nunca terminan en su tiempo simulado.
  setUp(rootBundle.clear);

  group('Login', () {
    testWidgets('pide llenar los campos vacíos', (tester) async {
      await tester.pumpWidget(const StoreApp());

      await tester.tap(find.text('Aceptar'));
      await tester.pump();

      expect(find.text('Ingresa tu usuario o correo'), findsOneWidget);
      expect(find.text('Ingresa tu contraseña'), findsOneWidget);
    });

    testWidgetsWithFakeApi('avisa cuando las credenciales son incorrectas', (
      tester,
    ) async {
      await tester.pumpWidget(const StoreApp());

      await login(tester, 'emilys', 'incorrecta');

      expect(find.text('Usuario o contraseña incorrectos'), findsOneWidget);
      expect(find.text('TIENDA EXAMEN'), findsOneWidget);
    });

    testWidgetsWithFakeApi(
      'entra a la pantalla principal con el usuario de prueba',
      (tester) async {
        await tester.pumpWidget(const StoreApp());

        await login(tester, 'emilys', 'emilyspass');

        expect(find.text('Productos'), findsOneWidget);
        expect(find.text('TIENDA EXAMEN'), findsNothing);
      },
    );
  });

  group('Inicio', () {
    testWidgetsWithFakeApi('muestra la lista de productos', (tester) async {
      await pumpHome(tester);

      expect(find.text('Productos'), findsOneWidget);
      expect(find.text("men's clothing - \$109.95"), findsOneWidget);
      expect(find.text('jewelery - \$695.00'), findsOneWidget);
    });

    testWidgetsWithFakeApi('la barra inferior cambia a la lista de carritos', (
      tester,
    ) async {
      await pumpHome(tester);

      await tester.tap(find.text('Carritos'));
      await tester.pumpAndSettle();

      expect(find.text('Carritos de compra'), findsOneWidget);
      expect(find.text('Cliente - 1'), findsOneWidget);
      expect(find.text('Cliente - 2'), findsOneWidget);
    });

    testWidgetsWithFakeApi(
      'el detalle del carrito muestra cliente, productos y total',
      (tester) async {
        await pumpHome(tester);

        await tester.tap(find.text('Carritos'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Cliente - 2'));
        await tester.pumpAndSettle();

        expect(find.text('Carrito #3'), findsOneWidget);
        expect(find.text('Nombre: david morrison'), findsOneWidget);
        expect(find.text('\$109.95 x 2'), findsOneWidget);
        expect(find.text('\$219.90'), findsOneWidget);
        expect(find.text('Total: \$283.90'), findsOneWidget);
      },
    );
  });
}
