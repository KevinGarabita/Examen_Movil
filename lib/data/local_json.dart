import 'dart:convert';

import 'package:flutter/services.dart';

/// Lee un archivo de `assets/data` y lo decodifica igual que el cuerpo de una
/// respuesta HTTP, así los servicios reciben la misma estructura que la API.
Future<dynamic> readLocalJson(String fileName) async {
  final content = await rootBundle.loadString('assets/data/$fileName');
  return jsonDecode(content);
}
