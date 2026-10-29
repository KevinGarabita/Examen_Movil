import 'package:flutter/material.dart';

import 'package:examen_movil/cart_detail/cart_detail_screen.dart';
import 'package:examen_movil/cart_detail/cart_detail_service.dart';
import 'package:examen_movil/carts/cart.dart';
import 'package:examen_movil/carts/carts_service.dart';
import 'package:examen_movil/widgets/cart_list_tile.dart';
import 'package:examen_movil/widgets/future_content.dart';

class CartsScreen extends StatefulWidget {
  final CartsService cartsService;
  final CartDetailService cartDetailService;

  const CartsScreen({
    super.key,
    required this.cartsService,
    required this.cartDetailService,
  });

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  late Future<List<Cart>> _cartsFuture;

  @override
  void initState() {
    super.initState();
    _cartsFuture = widget.cartsService.getCarts();
  }

  void _reload() {
    setState(() => _cartsFuture = widget.cartsService.getCarts());
  }

  void _openDetail(Cart cart) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CartDetailScreen(
          cartDetailService: widget.cartDetailService,
          cartId: cart.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carritos de compra')),
      body: FutureContent<List<Cart>>(
        future: _cartsFuture,
        onRetry: _reload,
        builder: (context, carts) => ListView.builder(
          itemCount: carts.length,
          itemBuilder: (context, index) {
            final cart = carts[index];
            return CartListTile(cart: cart, onTap: () => _openDetail(cart));
          },
        ),
      ),
    );
  }
}
