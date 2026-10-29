import 'package:examen_movil/base/response.dart';

abstract interface class Adapter<I, O> {
  Response<O> execute(I input);
}
