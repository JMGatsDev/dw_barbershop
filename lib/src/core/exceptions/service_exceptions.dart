class ServiceExceptions implements Exception {
  ServiceExceptions({
    required this.message,
  });

  final String message;
}
