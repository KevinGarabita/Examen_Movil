import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../services/cart_service.dart';
import '../widgets/cart_list_tile.dart';
import '../widgets/future_content.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  final _cartService = CartService();
  late Future<List<Cart>> _cartsFuture;

  @override
  void initState() {
    super.initState();
    _cartsFuture = _cartService.getCarts();
  }

  void _reload() {
    setState(() => _cartsFuture = _cartService.getCarts());
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
          itemBuilder: (context, index) => CartListTile(cart: carts[index]),
        ),
      ),
    );
  }
}
