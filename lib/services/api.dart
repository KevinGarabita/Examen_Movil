import 'dart:convert';

import 'package:http/http.dart' as http;

const _fakeStoreUrl = 'https://fakestoreapi.com';

/// Tiempo máximo de espera de cada petición. Si la API no responde a tiempo,
/// la pantalla muestra el error en lugar de quedarse cargando.
const apiTimeout = Duration(seconds: 10);

/// Hace un GET a Fake Store API y devuelve el cuerpo de la respuesta ya
/// decodificado. Lanza una excepción si la API responde con un error.
Future<dynamic> getFromFakeStore(String path) async {
  final url = Uri.parse('$_fakeStoreUrl$path');
  final response = await http.get(url).timeout(apiTimeout);

  if (response.statusCode != 200) {
    throw Exception('Error ${response.statusCode} al consultar $url');
  }
  return jsonDecode(response.body);
}
