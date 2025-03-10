class NetworkException implements Exception {
  final String? message;
  final int? statusCode;

  NetworkException({
    this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return "NetworkException: ${message ?? 'no message given'}. Status code: $statusCode";
  }
}
