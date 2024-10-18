import 'package:dw_barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';

abstract interface class UserRepository {
 Future<Either<AuthException,String>> login(String email, String password);

}