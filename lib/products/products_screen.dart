import 'package:flutter/material.dart';

import 'package:examen_movil/product_by_id/product_by_id_service.dart';
import 'package:examen_movil/product_by_id/product_detail_screen.dart';
import 'package:examen_movil/products/product.dart';
import 'package:examen_movil/products/products_service.dart';
import 'package:examen_movil/widgets/future_content.dart';
import 'package:examen_movil/widgets/product_list_tile.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsService productsService;
  final ProductByIdService productByIdService;

  const ProductsScreen({
    super.key,
    required this.productsService,
    required this.productByIdService,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.productsService.getProducts();
  }

  void _reload() {
    setState(() => _productsFuture = widget.productsService.getProducts());
  }

  void _openDetail(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          productByIdService: widget.productByIdService,
          productId: product.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos')),
      body: FutureContent<List<Product>>(
        future: _productsFuture,
        onRetry: _reload,
        builder: (context, products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductListTile(
              product: product,
              onTap: () => _openDetail(product),
            );
          },
        ),
      ),
    );
  }
}
