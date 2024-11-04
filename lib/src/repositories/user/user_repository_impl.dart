import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
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

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.get('/me');
      return Success(
        value: UserModel.fromMap(data),
      );
    } on DioException catch (e, s) {
      log('Error ao busca usuário Logado', error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(
          messages: 'Erro ao bustar usuário logado',
        ),
      );
    } on ArgumentError catch (e, s) {
      log(
        'Json invalido',
        error: e,
        stackTrace: s,
      );
      return Failure(
        exception: RepositoryException(
          messages: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM'
      });
      return Success(value: nil);
    } on DioException catch (e, s) {
      log('Error ao registrar Admin', error: e, stackTrace: s);
      return Failure(
          exception: RepositoryException(messages: 'Erro ao registrar Admin'));
    }
  }

  @override
  Future<Either<RepositoryException, List<UserModel>>> getEmployees(
      int barbershopId) async {
    try {
      final Response(:List data) = await restClient.auth
          .get('/users', queryParameters: {'barbershop_id': barbershopId});

      final employees = data.map((e) => UserModelEmployee.fromMap(e)).toList();
      return Success(value: employees);
    } on DioException catch (e, s) {
      log('Erro ao buscar colaboradores', error: e, stackTrace: s);
      return Failure(
          exception:
              RepositoryException(messages: 'Erro ao buscar colaboradores'));
    } on ArgumentError catch (e, s) {
      log('Erro ao converter colaboradores (Json Invalido)',
          error: e, stackTrace: s);
      return Failure(
          exception: RepositoryException(
              messages: 'Erro ao buscar colaboradores ou Json Invalido'));
    }
  }
}
