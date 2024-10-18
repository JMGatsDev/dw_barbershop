sealed class AuthException implements Exception {
  AuthException({
    required this.message,
  });
  final String message;
}

class AuthError extends AuthException {
  AuthError({required super.message});
}

class AuthUnauthorizedException extends AuthException {
  AuthUnauthorizedException() : super(message: '');
}
