import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';
import 'package:dw_barbershop/src/model/schedule_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/funcionalProgram/either.dart';

abstract interface class ScheduleRepository {
  Future<Either<RepositoryException, Nil>> scheduleClient(
      ({
        int barberShopId,
        String clientName,
        DateTime date,
        int time,
        int userId,
      }) scheduleData);

  Future<Either<RepositoryException, List<ScheduleModel>>> findScheduleByDate(
      ({DateTime date, int userId}) filter);
}
