import 'package:flutter/material.dart';

import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/products/product.dart';
import 'package:examen_movil/utils/price_formatter.dart';
import 'package:examen_movil/widgets/future_content.dart';
import 'package:examen_movil/widgets/primary_button.dart';
import 'package:examen_movil/widgets/product_image.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductByIdService productByIdService;
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productByIdService,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = widget.productByIdService.getProductById(widget.productId);
  }

  void _reload() {
    setState(() {
      _productFuture = widget.productByIdService.getProductById(
        widget.productId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del producto')),
      body: FutureContent<Product>(
        future: _productFuture,
        onRetry: _reload,
        builder: (context, product) => _ProductDetail(product: product),
      ),
    );
  }
}

class _ProductDetail extends StatelessWidget {
  const _ProductDetail({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(product.title, style: textTheme.headlineSmall),
          const SizedBox(height: 44),
          Center(child: ProductImage(url: product.image, size: 144)),
          const SizedBox(height: 40),
          Text(product.description, textAlign: TextAlign.center),
          const SizedBox(height: 28),
          Text(
            'Precio: ${formatPrice(product.price)}',
            textAlign: TextAlign.center,
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          // Los botones todavía no tienen acción.
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Agregar',
                  icon: Icons.add_shopping_cart,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'Eliminar',
                  icon: Icons.delete_outline,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
