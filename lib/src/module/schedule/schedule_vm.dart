import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/schedule/schedule_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/funcionalProgram/nil.dart';

part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.inital();

  void hourSelect(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void dateSelect(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel usermodel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();

    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final scheduleRepository = ref.read(scheduleRepositoryProvider);
    final BarbershopModel(id: barberId) =
        await ref.watch(getMyBarbershopProvider.future);
    final data = (
      barberShopId: barberId,
      clientName: clientName,
      date: scheduleDate!,
      time: scheduleHour!,
      userId: usermodel.id,
    );
    final scheduleResult = await scheduleRepository.scheduleClient(data);

    switch (scheduleResult) {
      case Success<RepositoryException, Nil>():
        state = state.copyWith(status: ScheduleStateStatus.success);
      case Failure<RepositoryException, Nil>():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }
    asyncLoaderHandler.close();
  }
}
