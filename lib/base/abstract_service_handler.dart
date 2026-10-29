import 'package:examen_movil/base/custom_exception.dart';
import 'package:examen_movil/base/handler.dart';

abstract class AbstractServiceHandler<U, T> implements Handler<U, T> {
  @override
  Future<T> execute(U input) async {
    try {
      // Lógica principal delegada al método abstracto doExecute
      return await doExecute(input);
    } on CustomException {
      // La excepción personalizada se re-lanza tal cual para que la pantalla
      // pueda revisar el status (por ejemplo, credenciales incorrectas)
      rethrow;
    } catch (e) {
      // Cualquier otro error se envuelve indicando qué servicio falló
      throw Exception('Error executing service=$runtimeType: $e');
    }
  }

  // Método abstracto que las clases hijas deben implementar
  Future<T> doExecute(U input);
}
