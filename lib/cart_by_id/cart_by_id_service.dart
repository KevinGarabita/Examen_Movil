import 'dart:convert';

import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_api.dart';
import 'package:examen_movil/carts/cart.dart';

class CartByIdService extends AbstractServiceHandler<int, Cart> {
  final CartByIdApi cartByIdApi;

  CartByIdService({required this.cartByIdApi});

  // Atajo de conveniencia: delega en execute()
  Future<Cart> getCartById(int id) {
    return execute(id);
  }

  // Lógica principal: llama al API y convierte el JSON en un objeto Cart
  @override
  Future<Cart> doExecute(int input) async {
    final body = await cartByIdApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return Cart.fromJson(json);
  }
}
