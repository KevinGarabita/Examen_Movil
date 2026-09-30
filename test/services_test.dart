import 'package:flutter_test/flutter_test.dart';

import 'package:examen_movil/services/auth_service.dart';
import 'package:examen_movil/services/cart_service.dart';
import 'package:examen_movil/services/product_service.dart';
import 'package:examen_movil/services/user_service.dart';

import 'fake_api.dart';

void main() {
  testWithFakeApi(
    'carga los productos y convierte los precios enteros a double',
    () async {
      final products = await ProductService().getProducts();
      final bracelet = await ProductService().getProductById(5);

      expect(products.map((product) => product.id), [1, 5]);
      expect(bracelet.price, 695.0);
    },
  );

  testWithFakeApi('carga el carrito 3 con su usuario', () async {
    final cart = await CartService().getCartById(3);
    final user = await UserService().getUserById(cart.userId);

    expect(cart.products.map((item) => item.productId), [1, 9]);
    expect(cart.products.map((item) => item.quantity), [2, 1]);
    expect(user.fullName, 'david morrison');
    expect(user.email, 'morrison@gmail.com');
  });

  testWithFakeApi('lanza un error si la API no responde bien', () async {
    await expectLater(ProductService().getProductById(99), throwsException);
  });

  testWithFakeApi(
    'el login acepta al usuario de prueba y rechaza la contraseña incorrecta',
    () async {
      final authService = AuthService();

      final user = await authService.login('emilys', 'emilyspass');
      expect(user?.firstName, 'Emily');
      expect(await authService.login('emilys', 'incorrecta'), isNull);
    },
  );
}
