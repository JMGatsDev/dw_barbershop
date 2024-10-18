import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/core/rest_client/rest_client.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;
  @override
  Future<Either<AuthException, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(value: data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('login ou senha Invalidos', error: e, stackTrace: s);
          return Failure(exception: AuthUnauthorizedException());
        }
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      return Failure(
        exception: AuthError(
          message: e.message.toString(),
        ),
      );
    }
  }
}
