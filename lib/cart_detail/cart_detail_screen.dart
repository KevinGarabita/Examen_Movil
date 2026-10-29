import 'package:flutter/material.dart';

import 'package:examen_movil/cart_detail/cart_detail.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/utils/price_formatter.dart';
import 'package:examen_movil/widgets/cart_item_tile.dart';
import 'package:examen_movil/widgets/future_content.dart';
import 'package:examen_movil/widgets/section_title.dart';

class CartDetailScreen extends StatefulWidget {
  final CartDetailService cartDetailService;
  final int cartId;

  const CartDetailScreen({
    super.key,
    required this.cartDetailService,
    required this.cartId,
  });

  @override
  State<CartDetailScreen> createState() => _CartDetailScreenState();
}

class _CartDetailScreenState extends State<CartDetailScreen> {
  late Future<CartDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = widget.cartDetailService.getCartDetail(widget.cartId);
  }

  void _reload() {
    setState(() {
      _detailFuture = widget.cartDetailService.getCartDetail(widget.cartId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrito #${widget.cartId}')),
      body: FutureContent<CartDetail>(
        future: _detailFuture,
        onRetry: _reload,
        builder: (context, detail) => _CartDetailView(detail: detail),
      ),
    );
  }
}

class _CartDetailView extends StatelessWidget {
  const _CartDetailView({required this.detail});

  final CartDetail detail;

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
