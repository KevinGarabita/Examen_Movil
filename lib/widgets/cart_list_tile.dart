import 'package:flutter/material.dart';

import '../models/cart.dart';
import 'cart_icon.dart';

class CartListTile extends StatelessWidget {
  const CartListTile({super.key, required this.cart, this.onTap});

  final Cart cart;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CartIcon(size: 50),
      title: Text('Cliente - ${cart.userId}'),
      subtitle: const Text('Click para ver detalles'),
      onTap: onTap,
    );
  }
}
