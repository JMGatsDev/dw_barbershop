import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';
import 'package:dw_barbershop/src/core/rest_client/rest_client.dart';
import 'package:dw_barbershop/src/model/schedule_model.dart';

import './schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient restClient;
  ScheduleRepositoryImpl({
    required this.restClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barberShopId,
        String clientName,
        DateTime date,
        int time,
        int userId
      }) scheduleData) async {
    try {
      await restClient.auth.post('/schedules', data: {
        'barberShop_id': scheduleData.barberShopId,
        'user_id': scheduleData.userId,
        'client_name': scheduleData.clientName,
        'date': scheduleData.date.toIso8601String(),
        'time': scheduleData.time
      });
      return Success(value: nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar agendamento', error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(messages: 'Erro ao  agendar horario'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filter) async {
    try {
      final Response(:List data) = await restClient.auth.get('/schedules',
          queryParameters: {
            'user_id': filter.userId,
            'date': filter.date.toIso8601String()
          });
          log(data.toString());
      final schedules = data.map((s) => ScheduleModel.fromMap(s)).toList();
      return Success(value: schedules);
    } on DioException catch (e, s) {
      log('Erro ao buscar agendamentos da data escolhida',
          error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(
            messages: 'Erro ao buscar agendamentos da data escolhida'),
      );
    } on ArgumentError catch (e, s) {
      log('Json Invalido', error: e, stackTrace: s);
      return Failure(
        exception: RepositoryException(messages: 'Json Invalido'),
      );
    }
  }
}
