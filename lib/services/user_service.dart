import '../models/user.dart';
import 'api.dart';

/// Consulta de usuarios en Fake Store API.
class UserService {
  Future<User> getUserById(int id) async {
    final data = await getFromFakeStore('/users/$id');
    return User.fromJson(data);
  }
}
