import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../services/cart_service.dart';
import '../services/product_service.dart';
import '../services/user_service.dart';
import '../utils/price_formatter.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/future_content.dart';
import '../widgets/section_title.dart';

class CartDetailScreen extends StatefulWidget {
  const CartDetailScreen({super.key, required this.cartId});

  final int cartId;

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  final _cartService = CartService();
  final _userService = UserService();
  final _productService = ProductService();
  late Future<_CartDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _loadDetail();
  }

  void _reload() {
    setState(() => _detailFuture = _loadDetail());
  }

  Future<_CartDetail> _loadDetail() async {
    final cart = await _cartService.getCartById(widget.cartId);
    // El usuario y los productos no dependen entre sí, se piden al mismo tiempo.
    final userFuture = _userService.getUserById(cart.userId);
    final linesFuture = Future.wait(cart.products.map(_loadLine));
    return _CartDetail(user: await userFuture, lines: await linesFuture);
  }

  Future<_CartLine> _loadLine(CartProduct item) async {
    final product = await _productService.getProductById(item.productId);
    return _CartLine(product: product, quantity: item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrito #${widget.cartId}')),
      body: FutureContent<_CartDetail>(
        future: _detailFuture,
        onRetry: _reload,
        builder: (context, detail) => _CartDetailView(detail: detail),
      ),
    );
  }
}

class _CartDetail {
  const _CartDetail({required this.user, required this.lines});

  final User user;
  final List<_CartLine> lines;

  double get total =>
      lines.fold(0, (sum, line) => sum + line.product.price * line.quantity);
}

class _CartLine {
  const _CartLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;
}

class _CartDetailView extends StatelessWidget {
  const _CartDetailView({required this.detail});

  final _CartDetail detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle(text: 'Cliente'),
        Text('Nombre: ${detail.user.fullName}', style: textTheme.titleMedium),
        const SizedBox(height: 4),
        Text('Correo: ${detail.user.email}', style: textTheme.titleMedium),
        const SizedBox(height: 16),
        const SectionTitle(text: 'Productos'),
        for (final line in detail.lines)
          CartItemTile(product: line.product, quantity: line.quantity),
        const Divider(),
        Text(
          'Total: ${formatPrice(detail.total)}',
          textAlign: TextAlign.end,
          style: textTheme.titleLarge,
        ),
      ],
    );
  }
}
