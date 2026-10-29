import 'dart:convert';

import 'package:examen_movil/base/custom_exception.dart';
import 'package:examen_movil/base/handler.dart';
import 'package:http/http.dart' as http;

abstract class AbstractApiHandler<U, T> implements Handler<U, T> {
  // Tiempo máximo de espera de cada petición. Si la API no responde a tiempo,
  // la pantalla muestra el error en lugar de quedarse cargando.
  static const Duration timeout = Duration(seconds: 10);

  final http.Client httpClient;

  AbstractApiHandler({required this.httpClient});

  // Método auxiliar para serializar objetos
  String toJson(Object obj) {
    return jsonEncode(obj);
  }

  @override
  Future<T> execute(U input) => doExecute(input);

  // Método abstracto que las clases hijas deben implementar
  Future<T> doExecute(U input);

  // Valida la respuesta: un status >= 400 se lanza como CustomException para
  // que el servicio y la pantalla conserven el código HTTP
  String _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      throw CustomException(
        code: response.statusCode,
        status: response.statusCode,
        message: 'External service error: ${response.body}',
      );
    }
    return response.body;
  }

  // Ejecuta la petición; los errores de red o timeout se envuelven, pero la
  // CustomException del status HTTP se re-lanza tal cual
  Future<String> _send(
    String name,
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(timeout);
      return _handleResponse(response);
    } on CustomException {
      rethrow;
    } catch (e) {
      throw Exception('Unexpected error in $name: $e');
    }
  }

  // Petición POST
  Future<String> webClientPost(
    String url,
    Object request, {
    Map<String, String>? headers,
  }) {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    return _send(
      'webClientPost',
      () => httpClient.post(
        Uri.parse(url),
        headers: defaultHeaders,
        body: toJson(request),
      ),
    );
  }

  // Petición POST Multipart (Usando http.MultipartRequest)
  Future<String> webClientPostMultipart(
    String url,
    Map<String, String> fields, {
    Map<String, String>? headers,
    List<http.MultipartFile>? files,
  }) {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    if (headers != null) {
      request.headers.addAll(headers);
    }
    request.headers['Accept'] = 'application/json';

    request.fields.addAll(fields);
    if (files != null) {
      request.files.addAll(files);
    }

    return _send(
      'webClientPostMultipart',
      () async => http.Response.fromStream(await httpClient.send(request)),
    );
  }

  // Petición GET
  Future<String> webClientGet(String url, {Map<String, String>? headers}) {
    final defaultHeaders = {'Accept': 'application/json', ...?headers};

    return _send(
      'webClientGet',
      () => httpClient.get(Uri.parse(url), headers: defaultHeaders),
    );
  }

  // Petición DELETE
  Future<String> webClientDelete(String url, {Map<String, String>? headers}) {
    final defaultHeaders = {'Accept': 'application/json', ...?headers};

    return _send(
      'webClientDelete',
      () => httpClient.delete(Uri.parse(url), headers: defaultHeaders),
    );
  }

  // Petición PUT
  Future<String> webClientPut(
    String url,
    Object request, {
    Map<String, String>? headers,
  }) {
    final defaultHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers,
    };

    return _send(
      'webClientPut',
      () => httpClient.put(
        Uri.parse(url),
        headers: defaultHeaders,
        body: toJson(request),
      ),
    );
  }
}
