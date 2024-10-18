import 'package:dw_barbershop/src/core/constants/local_storege_keys.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exceptions.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/services/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  UserLoginServiceImpl({
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  Future<Either<ServiceExceptions, Nil>> excute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Failure<AuthException, String>(:final exception):
        return switch (exception) {
          AuthError() => Failure(
              exception: ServiceExceptions(message: 'Erro ao realizar login')),
          AuthUnauthorizedException() => Failure(
              exception:
                  ServiceExceptions(message: 'Login ou senha Invalidos')),
        };
      case Success<AuthException, String>(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStoregeKeys.accessToken, accessToken);
        return Success(value: Nil());
    }
  }
}
