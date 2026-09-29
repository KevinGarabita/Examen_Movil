import 'package:flutter/material.dart';

/// Imagen de producto en un cuadro de tamaño fijo, sin recortarla.
class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.url, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.image_not_supported_outlined,
          color: Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
