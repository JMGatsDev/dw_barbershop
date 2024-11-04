import '../../core/exceptions/auth_exceptions.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/funcionalProgram/either.dart';
import '../../core/funcionalProgram/nil.dart';
import '../../model/user_model.dart';

abstract interface class UserRepository {
  Future<Either<AuthException, String>> login(String email, String password);

  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({
        String name,
        String email,
        String password,
      }) userData);

  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId);
}
