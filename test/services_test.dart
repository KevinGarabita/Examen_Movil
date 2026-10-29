import 'package:examen_movil/base/custom_exception.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_api.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_service.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/login/login_api.dart';
import 'package:examen_movil/login/login_service.dart';
import 'package:examen_movil/product_by_id/product_by_id_api.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/products_api.dart';
import 'package:examen_movil/products/products_service.dart';
import 'package:examen_movil/user_by_id/user_by_id_api.dart';
import 'package:examen_movil/user_by_id/user_by_id_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_api.dart';

void main() {
  final productsService = ProductsService(
    productsApi: ProductsApi(httpClient: fakeApi),
  );
  final productByIdService = ProductByIdService(
    productByIdApi: ProductByIdApi(httpClient: fakeApi),
  );
  final cartByIdService = CartByIdService(
    cartByIdApi: CartByIdApi(httpClient: fakeApi),
  );
  final userByIdService = UserByIdService(
    userByIdApi: UserByIdApi(httpClient: fakeApi),
  );

  test(
    'carga los productos y convierte los precios enteros a double',
    () async {
      final products = await productsService.getProducts();
      final bracelet = await productByIdService.getProductById(5);

      expect(products.map((product) => product.id), [1, 5]);
      expect(bracelet.price, 695.0);
    },
  );

  test('carga el carrito 3 con su usuario', () async {
    final cart = await cartByIdService.getCartById(3);
    final user = await userByIdService.getUserById(cart.userId);

    expect(cart.products.map((item) => item.productId), [1, 9]);
    expect(cart.products.map((item) => item.quantity), [2, 1]);
    expect(user.fullName, 'david morrison');
    expect(user.email, 'morrison@gmail.com');
  });

  test('arma el detalle del carrito con cliente, productos y total', () async {
    final detail = await CartDetailService(
      cartByIdService: cartByIdService,
      userByIdService: userByIdService,
      productByIdService: productByIdService,
    ).getCartDetail(3);

    expect(detail.user.fullName, 'david morrison');
    expect(detail.lines.map((line) => line.quantity), [2, 1]);
    expect(detail.total, closeTo(283.90, 0.001));
  });

  test('lanza un error si la API no responde bien', () async {
    await expectLater(productByIdService.getProductById(99), throwsException);
  });

  test(
    'el login acepta al usuario de prueba y rechaza la contraseña incorrecta',
    () async {
      final loginService = LoginService(
        loginApi: LoginApi(httpClient: fakeApi),
      );

      final user = await loginService.login('emilys', 'emilyspass');
      expect(user.firstName, 'Emily');

      // DummyJSON responde 400 y la CustomException conserva el status
      await expectLater(
        loginService.login('emilys', 'incorrecta'),
        throwsA(isA<CustomException>().having((e) => e.status, 'status', 400)),
      );
    },
  );
}
