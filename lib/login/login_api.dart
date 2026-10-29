import 'package:examen_movil/base/abstract_api_handler.dart';
import 'package:examen_movil/login/user_credentials_dto.dart';

class LoginApi extends AbstractApiHandler<UserCredentialsDto, String> {
  LoginApi({required super.httpClient});

  static const String _url = 'https://dummyjson.com/auth/login';

  @override
  Future<String> doExecute(UserCredentialsDto input) {
    // webClientPost maneja la petición POST y valida status >= 400
    return webClientPost(_url, input.toJson());
  }
}
