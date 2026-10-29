import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/cart_by_id/cart_by_id_service.dart';
import 'package:examen_movil/cart_detail/cart_detail.dart';
import 'package:examen_movil/carts/cart.dart';
import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/user_by_id/user_by_id_service.dart';

class CartDetailService extends AbstractServiceHandler<int, CartDetail> {
  final CartByIdService cartByIdService;
  final UserByIdService userByIdService;
  final ProductByIdService productByIdService;

  CartDetailService({
    required this.cartByIdService,
    required this.userByIdService,
    required this.productByIdService,
  });

  // Atajo de conveniencia: delega en execute()
  Future<CartDetail> getCartDetail(int cartId) {
    return execute(cartId);
  }

  // Lógica principal: el carrito solo trae el id de cada producto, así que se
  // consultan el usuario y los productos para armar el detalle completo
  @override
  Future<CartDetail> doExecute(int input) async {
    final cart = await cartByIdService.getCartById(input);
    // El usuario y los productos no dependen entre sí, se piden al mismo tiempo.
    final userFuture = userByIdService.getUserById(cart.userId);
    final linesFuture = Future.wait(cart.products.map(_loadLine));
    return CartDetail(user: await userFuture, lines: await linesFuture);
  }

  Future<CartLine> _loadLine(CartProduct item) async {
    final product = await productByIdService.getProductById(item.productId);
    return CartLine(product: product, quantity: item.quantity);
  }
}
