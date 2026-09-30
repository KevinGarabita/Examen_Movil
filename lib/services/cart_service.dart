import '../models/cart.dart';
import 'api.dart';

/// Consulta de carritos en Fake Store API.
class CartService {
  Future<List<Cart>> getCarts() async {
    final List<dynamic> data = await getFromFakeStore('/carts');
    return data.map((json) => Cart.fromJson(json)).toList();
  }

  Future<Cart> getCartById(int id) async {
    final data = await getFromFakeStore('/carts/$id');
    return Cart.fromJson(data);
  }
}
