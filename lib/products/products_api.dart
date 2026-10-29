import 'package:examen_movil/base/abstract_api_handler.dart';

class ProductsApi extends AbstractApiHandler<void, String> {
  ProductsApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/products';

  @override
  Future<String> doExecute(void input) {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet(_url);
  }
}
