import 'package:dw_barbershop/src/core/funcionalProgram/nil.dart';

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
}
