sealed class Either<E extends Exception, S> {}

class Success<E extends Exception, S> extends Either<E, S> {
  Success({required this.value});
  final S value;
}

class Failure<E extends Exception, S> extends Either<E, S> {
  Failure({required this.exception});
  final E exception;
}
