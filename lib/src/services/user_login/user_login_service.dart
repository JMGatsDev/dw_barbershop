import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';

import '../../core/exceptions/service_exceptions.dart';

abstract interface class UserLoginService {

Future<Either<ServiceExceptions,Nil>> excute(String email, String password);
}