import 'dart:convert';

import 'package:examen_movil/base/abstract_service_handler.dart';
import 'package:examen_movil/user_by_id/user.dart';
import 'package:examen_movil/user_by_id/user_by_id_api.dart';

class UserByIdService extends AbstractServiceHandler<int, User> {
  final UserByIdApi userByIdApi;

  UserByIdService({required this.userByIdApi});

  // Atajo de conveniencia: delega en execute()
  Future<User> getUserById(int id) {
    return execute(id);
  }

  // Lógica principal: llama al API y convierte el JSON en un objeto User
  @override
  Future<User> doExecute(int input) async {
    final body = await userByIdApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return User.fromJson(json);
  }
}
