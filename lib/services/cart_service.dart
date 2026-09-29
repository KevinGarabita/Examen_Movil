import '../data/local_json.dart';
import '../models/cart.dart';

/// Consulta de carritos. Por ahora usa los datos locales.
class CartService {
  Future<List<Cart>> getCarts() async {
    final List<dynamic> data = await readLocalJson('carts.json');
    return data.map((json) => Cart.fromJson(json)).toList();
  }

  Future<Cart> getCartById(int id) async {
    final List<dynamic> data = await readLocalJson('carts.json');
    final json = data.firstWhere((cart) => cart['id'] == id);
    return Cart.fromJson(json);
  }
}
