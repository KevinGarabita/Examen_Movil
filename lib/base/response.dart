class Response<T> {
  final T? data;
  final String? message;
  final bool success;

  Response({this.data, this.message, this.success = true});
}
