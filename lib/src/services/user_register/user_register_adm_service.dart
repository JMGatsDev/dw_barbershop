import '../../core/exceptions/service_exceptions.dart';
import '../../core/funcionalProgram/either.dart';
import '../../core/funcionalProgram/nil.dart';

abstract interface class UserRegisterAdmService {
  Future<Either<ServiceExceptions, Nil>> execute(
      ({
        String name,
        String email,
        String password,
      }) userData);
}
