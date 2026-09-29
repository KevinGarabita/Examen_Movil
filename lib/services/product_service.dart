import '../data/local_json.dart';
import '../models/product.dart';

/// Consulta de productos. Por ahora usa los datos locales.
class ProductService {
  Future<List<Product>> getProducts() async {
    final List<dynamic> data = await readLocalJson('products.json');
    return data.map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProductById(int id) async {
    final List<dynamic> data = await readLocalJson('products.json');
    final json = data.firstWhere((product) => product['id'] == id);
    return Product.fromJson(json);
  }
}
