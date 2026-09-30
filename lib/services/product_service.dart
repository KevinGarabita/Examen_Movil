import '../models/product.dart';
import 'api.dart';

/// Consulta de productos en Fake Store API.
class ProductService {
  Future<List<Product>> getProducts() async {
    final List<dynamic> data = await getFromFakeStore('/products');
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final data = await getFromFakeStore('/products/$id');
    return Product.fromJson(data);
  }
}
