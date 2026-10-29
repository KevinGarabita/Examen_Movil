import 'dart:convert';

import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/products/product.dart';
import 'package:examen_movil/products/products_api.dart';

class ProductsService extends AbstractServiceHandler<void, List<Product>> {
  final ProductsApi productsApi;

  ProductsService({required this.productsApi});

  // Atajo de conveniencia: delega en execute()
  Future<List<Product>> getProducts() {
    return execute(null);
  }

  // Lógica principal: llama al API de productos y convierte la lista del JSON en objetos Product
  @override
  Future<List<Product>> doExecute(void input) async {
    final body = await productsApi.execute(null);
    final products = jsonDecode(body) as List<dynamic>;
    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
