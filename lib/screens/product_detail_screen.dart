import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../utils/price_formatter.dart';
import '../widgets/future_content.dart';
import '../widgets/primary_button.dart';
import '../widgets/product_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _productService = ProductService();
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = _productService.getProductById(widget.productId);
  }

  void _reload() {
    setState(() {
      _productFuture = _productService.getProductById(widget.productId);
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
