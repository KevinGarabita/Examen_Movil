import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';
import 'product_image.dart';

/// Producto dentro de un carrito, con su precio por cantidad y el subtotal.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ProductImage(url: product.image, size: 50),
      title: Text(product.title, maxLines: 2),
      subtitle: Text('${formatPrice(product.price)} x $quantity'),
      trailing: Text(formatPrice(product.price * quantity)),
    );
  }
}
