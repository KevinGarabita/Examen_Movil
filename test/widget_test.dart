import 'package:flutter_test/flutter_test.dart';

import 'package:examen_movil/main.dart';

void main() {
  testWidgets('muestra la lista de productos', (tester) async {
    await tester.pumpWidget(const StoreApp());
    await tester.pumpAndSettle();

    expect(find.text('Productos'), findsOneWidget);
    expect(find.text("men's clothing - \$109.95"), findsOneWidget);
    expect(find.text('jewelery - \$695.00'), findsOneWidget);
  });
}
