class CustomException implements Exception {
  final int code;
  final int status;
  final String message;

  CustomException({
    required this.code,
    required this.status,
    required this.message,
  });

  @override
  String toString() => 'CustomException: [$status] (Code: $code) - $message';
}
