import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_user.dart';
import 'api.dart';

/// Inicio de sesión con el endpoint de autenticación de DummyJSON.
class AuthService {
  /// Devuelve null si el usuario o la contraseña son incorrectos.
  Future<AuthUser?> login(String username, String password) async {
    final response = await http
        .post(
          Uri.parse('https://dummyjson.com/auth/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'username': username, 'password': password}),
        )
        .timeout(apiTimeout);

    // DummyJSON responde 400 cuando las credenciales no coinciden.
    if (response.statusCode == 400) return null;
    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode} al iniciar sesión');
    }
    return AuthUser.fromJson(jsonDecode(response.body));
  }
}
