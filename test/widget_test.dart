import 'package:examen_movil/cart_by_id/cart_by_id_api.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_service.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/carts/carts_api.dart';
import 'package:examen_movil/carts/carts_service.dart';
import 'package:examen_movil/home/home_screen.dart';
import 'package:examen_movil/main.dart';
import 'package:examen_movil/product_by_id/product_by_id_api.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/products_api.dart';
import 'package:examen_movil/products/products_service.dart';
import 'package:examen_movil/theme/app_theme.dart';
import 'package:examen_movil/user_by_id/user_by_id_api.dart';
import 'package:examen_movil/user_by_id/user_by_id_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_api.dart';

Future<void> pumpHome(WidgetTester tester) async {
  final productByIdService = ProductByIdService(
    productByIdApi: ProductByIdApi(httpClient: fakeApi),
  );
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light,
      home: HomeScreen(
        productsService: ProductsService(
          productsApi: ProductsApi(httpClient: fakeApi),
        ),
        productByIdService: productByIdService,
        cartsService: CartsService(cartsApi: CartsApi(httpClient: fakeApi)),
        cartDetailService: CartDetailService(
          cartByIdService: CartByIdService(
            cartByIdApi: CartByIdApi(httpClient: fakeApi),
          ),
          userByIdService: UserByIdService(
            userByIdApi: UserByIdApi(httpClient: fakeApi),
          ),
          productByIdService: productByIdService,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> login(
  WidgetTester tester,
  String username,
  String password,
) async {
  await tester.enterText(
    find.widgetWithText(TextFormField, 'Usuario'),
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
  group('Login', () {
    testWidgets('pide llenar los campos vacíos', (tester) async {
      await tester.pumpWidget(StoreApp(httpClient: fakeApi));

      await tester.tap(find.text('Aceptar'));
      await tester.pump();

      expect(find.text('Ingresa tu usuario'), findsOneWidget);
      expect(find.text('Ingresa tu contraseña'), findsOneWidget);
    });

    testWidgets('avisa cuando las credenciales son incorrectas', (
      tester,
    ) async {
      await tester.pumpWidget(StoreApp(httpClient: fakeApi));

      await login(tester, 'emilys', 'incorrecta');

      expect(find.text('Usuario o contraseña incorrectos'), findsOneWidget);
      expect(find.text('TIENDA EXAMEN'), findsOneWidget);
    });

    testWidgets('entra a la pantalla principal con el usuario de prueba', (
      tester,
    ) async {
      await tester.pumpWidget(StoreApp(httpClient: fakeApi));

      await login(tester, 'emilys', 'emilyspass');

      expect(find.text('Productos'), findsOneWidget);
      expect(find.text('TIENDA EXAMEN'), findsNothing);
    });
  });

  group('Inicio', () {
    testWidgets('muestra la lista de productos', (tester) async {
      await pumpHome(tester);

      expect(find.text('Productos'), findsOneWidget);
      expect(find.text("men's clothing - \$109.95"), findsOneWidget);
      expect(find.text('jewelery - \$695.00'), findsOneWidget);
    });

    testWidgets('la barra inferior cambia a la lista de carritos', (
      tester,
    ) async {
      await pumpHome(tester);

      await tester.tap(find.text('Carritos'));
      await tester.pumpAndSettle();

      expect(find.text('Carritos de compra'), findsOneWidget);
      expect(find.text('Cliente - 1'), findsOneWidget);
      expect(find.text('Cliente - 2'), findsOneWidget);
    });

    testWidgets('el detalle del carrito muestra cliente, productos y total', (
      tester,
    ) async {
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
    });
  });
}
