import 'dart:convert';

import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/carts/cart.dart';
import 'package:examen_movil/carts/carts_api.dart';

class CartsService extends AbstractServiceHandler<void, List<Cart>> {
  final CartsApi cartsApi;

  CartsService({required this.cartsApi});

  // Atajo de conveniencia: delega en execute()
  Future<List<Cart>> getCarts() {
    return execute(null);
  }

  // Lógica principal: llama al API de carritos y convierte la lista del JSON en objetos Cart
  @override
  Future<List<Cart>> doExecute(void input) async {
    final body = await cartsApi.execute(null);
    final carts = jsonDecode(body) as List<dynamic>;
    return carts
        .map((item) => Cart.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
