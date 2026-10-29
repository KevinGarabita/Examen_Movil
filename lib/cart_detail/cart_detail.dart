import 'package:examen_movil/products/product.dart';
import 'package:examen_movil/user_by_id/user.dart';

// Carrito con su cliente y los datos completos de cada producto
class CartDetail {
  final User user;
  final List<CartLine> lines;

  CartDetail({required this.user, required this.lines});

  double get total =>
      lines.fold(0, (sum, line) => sum + line.product.price * line.quantity);
}

class CartLine {
  final Product product;
  final int quantity;

  CartLine({required this.product, required this.quantity});
}
