import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/price_formatter.dart';
import 'product_image.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product, this.onTap});

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProductImage(url: product.image, size: 50),
      // En el diseño el título se corta en la última palabra que cabe.
      title: Text(product.title, maxLines: 1),
      subtitle: Text('${product.category} - ${formatPrice(product.price)}'),
      onTap: onTap,
    );
  }
}
