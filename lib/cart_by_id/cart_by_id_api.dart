import 'package:examen_movil/base/abstract_api_handler.dart';

class CartByIdApi extends AbstractApiHandler<int, String> {
  CartByIdApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/carts';

  @override
  Future<String> doExecute(int input) {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet('$_url/$input');
  }
}
