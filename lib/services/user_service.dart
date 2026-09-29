import '../data/local_json.dart';
import '../models/user.dart';

/// Consulta de usuarios. Por ahora usa los datos locales.
class UserService {
  Future<User> getUserById(int id) async {
    final List<dynamic> data = await readLocalJson('users.json');
    final json = data.firstWhere((user) => user['id'] == id);
    return User.fromJson(json);
  }
}
