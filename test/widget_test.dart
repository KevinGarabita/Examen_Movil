import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:examen_movil/main.dart';

void main() {
  // Sin esto, una prueba recibe lecturas de JSON en caché que empezaron en la
  // prueba anterior y nunca terminan en su tiempo simulado.
  setUp(rootBundle.clear);

  testWidgets('muestra la lista de productos', (tester) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();

    expect(find.text('Productos'), findsOneWidget);
    expect(find.text("men's clothing - \$109.95"), findsOneWidget);
    expect(find.text('jewelery - \$695.00'), findsOneWidget);
  });

  testWidgets('la barra inferior cambia a la lista de carritos', (
    tester,
  ) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Carritos'));
    await tester.pumpAndSettle();

    expect(find.text('Carritos de compra'), findsOneWidget);
    expect(find.text('Cliente - 1'), findsNWidgets(2));
    expect(find.text('Cliente - 8'), findsOneWidget);
  });

  testWidgets('el detalle del carrito muestra cliente, productos y total', (
    tester,
  ) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();

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
}
