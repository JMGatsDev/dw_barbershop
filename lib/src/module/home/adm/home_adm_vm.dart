import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/home/adm/home_adm_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/funcionalProgram/either.dart';
import '../../../core/providers/application_provider.dart';

part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {
    final repository = ref.watch(userRepositoryProvider);

    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);

    final me = await ref.watch(getMeProvider.future);

    final employeesResult = await repository.getEmployees(barbershopId);

    switch (employeesResult) {
      case Success(value: final employeesData):
        final employees = <UserModel>[];
        if (me case UserModelAdm(workDays: _?, workHours: _?)) {
          employees.add(me);
        }
        employees.addAll(employeesData);
        return HomeAdmState(
            status: HomeAdmStateStatus.loaded, employee: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employee: []);
    }
  }

  Future<void> logout() => ref.read(logoutProvider.future).asyncLoader();
}