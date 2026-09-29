import 'package:flutter/material.dart';

/// Ícono de carrito con degradado, parecido a la ilustración del diseño.
class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [colorScheme.tertiary, colorScheme.tertiaryContainer],
      ).createShader(bounds),
      // El color debe ser opaco para que el degradado no se vea pálido.
      child: Icon(
        Icons.shopping_cart_outlined,
        size: size,
        color: colorScheme.tertiary,
      ),
    );
  }
}
