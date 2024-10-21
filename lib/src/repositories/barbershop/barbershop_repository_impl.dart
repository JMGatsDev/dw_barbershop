import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
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
}

