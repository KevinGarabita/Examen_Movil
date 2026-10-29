import 'package:examen_movil/base/abstract_api_handler.dart';

class CartsApi extends AbstractApiHandler<void, String> {
  CartsApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/carts';

  @override
  Future<String> doExecute(void input) {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet(_url);
  }
}
