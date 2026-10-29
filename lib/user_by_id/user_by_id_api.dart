import 'package:examen_movil/base/abstract_api_handler.dart';

class UserByIdApi extends AbstractApiHandler<int, String> {
  UserByIdApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/users';

  @override
  Future<String> doExecute(int input) {
    // webClientGet maneja la petición GET y valida status >= 400
    return webClientGet('$_url/$input');
  }
}
