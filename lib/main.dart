import 'package:examen_movil/cart_by_id/cart_by_id_api.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_service.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/carts/carts_api.dart';
import 'package:examen_movil/carts/carts_service.dart';
import 'package:examen_movil/login/login_api.dart';
import 'package:examen_movil/login/login_screen.dart';
import 'package:examen_movil/login/login_service.dart';
import 'package:examen_movil/product_by_id/product_by_id_api.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/products_api.dart';
import 'package:examen_movil/products/products_service.dart';
import 'package:examen_movil/theme/app_theme.dart';
import 'package:examen_movil/user_by_id/user_by_id_api.dart';
import 'package:examen_movil/user_by_id/user_by_id_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(StoreApp(httpClient: http.Client()));
}

class StoreApp extends StatelessWidget {
  final http.Client httpClient;

  const StoreApp({super.key, required this.httpClient});

  @override
  Widget build(BuildContext context) {
    // Un solo cliente HTTP compartido; cada Api lo recibe y cada Service
    // recibe su Api. Las pantallas reciben los servicios por constructor.
    final loginService = LoginService(
      loginApi: LoginApi(httpClient: httpClient),
    );
    final productsService = ProductsService(
      productsApi: ProductsApi(httpClient: httpClient),
    );
    final productByIdService = ProductByIdService(
      productByIdApi: ProductByIdApi(httpClient: httpClient),
    );
    final cartsService = CartsService(
      cartsApi: CartsApi(httpClient: httpClient),
    );
    final cartDetailService = CartDetailService(
      cartByIdService: CartByIdService(
        cartByIdApi: CartByIdApi(httpClient: httpClient),
      ),
      userByIdService: UserByIdService(
        userByIdApi: UserByIdApi(httpClient: httpClient),
      ),
      productByIdService: productByIdService,
    );

    return MaterialApp(
      title: 'Tienda Examen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: LoginScreen(
        loginService: loginService,
        productsService: productsService,
        productByIdService: productByIdService,
        cartsService: cartsService,
        cartDetailService: cartDetailService,
      ),
    );
  }
}
