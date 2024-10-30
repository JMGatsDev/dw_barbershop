import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';
import 'package:dw_barbershop/src/core/rest_client/rest_client.dart';

import 'package:dw_barbershop/src/model/barbershop_model.dart';

import 'package:dw_barbershop/src/model/user_model.dart';

import './barbershop_repository.dart';

class BarbershopRepositoryImpl implements BarbershopRepository {
  BarbershopRepositoryImpl({
    required this.restClient,
  });

  final RestClient restClient;
  @override
  Future<Either<RepositoryException, BarbershopModel>> getMyBarbershop(
      UserModel model) async {
    switch (model) {
      case UserModelAdm():
        final Response(data: List(first: data)) = await restClient.auth.get(
          '/barbershop',
          queryParameters: {'user_id': '#userAuthRef'},
        );
        return Success(
          value: BarbershopModel.fromMap(data),
        );
      case UserModelEmployee():
        final Response(:data) =
            await restClient.auth.get('/barbershop/${model.barberShopId}');
        return Success(
          value: BarbershopModel.fromMap(data),
        );
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> saveBarbershop(
      ({
        String email,
        String name,
        List<String> openingDays,
        List<int> openingHours
      }) data) async {
    try {
      await restClient.auth.post('/barbershop', data: {
        'user_id': '#userAuthRef',
        'name': data.name,
        'email': data.email,
        'openingDays': data.openingDays,
        'openingHours': data.openingHours
      });

      return Success(value: nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar barbearia', error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(messages: 'Erro ao registrar barbearia'),
      );
    }
  }
}
