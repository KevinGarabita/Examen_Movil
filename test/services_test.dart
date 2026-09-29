import 'package:flutter_test/flutter_test.dart';

import 'package:examen_movil/services/auth_service.dart';
import 'package:examen_movil/services/cart_service.dart';
import 'package:examen_movil/services/product_service.dart';
import 'package:examen_movil/services/user_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'carga los productos y convierte los precios enteros a double',
    () async {
      final products = await ProductService().getProducts();
      final bracelet = await ProductService().getProductById(5);

      expect(products, hasLength(20));
      expect(bracelet.price, 695.0);
    },
  );

  test('carga el carrito 3 con su usuario', () async {
    final cart = await CartService().getCartById(3);
    final user = await UserService().getUserById(cart.userId);

    expect(cart.products.map((item) => item.productId), [1, 9]);
    expect(cart.products.map((item) => item.quantity), [2, 1]);
    expect(user.fullName, 'david morrison');
    expect(user.email, 'morrison@gmail.com');
  });

  test(
    'el login acepta usuario o correo y rechaza la contraseña incorrecta',
    () async {
      final authService = AuthService();

      expect(await authService.login('emilys', 'emilyspass'), isNotNull);
      expect(
        await authService.login('emily.johnson@x.dummyjson.com', 'emilyspass'),
        isNotNull,
      );
      expect(await authService.login('emilys', 'incorrecta'), isNull);
    },
  );
}
