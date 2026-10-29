import 'dart:convert';

import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/login/login_api.dart';
import 'package:examen_movil/login/user_credentials_dto.dart';

class LoginService
    extends AbstractServiceHandler<UserCredentialsDto, AuthResponseDto> {
  final LoginApi loginApi;

  LoginService({required this.loginApi});

  // Atajo de conveniencia: arma las credenciales y delega en execute()
  Future<AuthResponseDto> login(String username, String password) {
    final credentials = UserCredentialsDto(
      username: username,
      password: password,
    );
    return execute(credentials);
  }

  // Lógica principal: llama al API de login y convierte el JSON en AuthResponseDto
  @override
  Future<AuthResponseDto> doExecute(UserCredentialsDto input) async {
    final body = await loginApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return AuthResponseDto.fromJson(json);
  }
}
