import '../data/local_json.dart';
import '../models/auth_user.dart';

/// Inicio de sesión. Por ahora valida contra el usuario de prueba local.
class AuthService {
  /// Devuelve null si el usuario o la contraseña no coinciden. Con los datos
  /// locales se acepta tanto el usuario como el correo de prueba.
  Future<AuthUser?> login(String username, String password) async {
    final Map<String, dynamic> testUser = await readLocalJson('auth_user.json');
    final isKnownUser =
        username == testUser['username'] || username == testUser['email'];

    if (!isKnownUser || password != testUser['password']) return null;
    return AuthUser.fromJson(testUser);
  }
}
