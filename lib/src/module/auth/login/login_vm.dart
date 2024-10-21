import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exceptions.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();
  Future<void> login(String email, String password) async {
    final loaderHandle = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.excute(email, password);
    switch (result) {
      case Success():
      //! invalidando os caches para evitar login com usuario errado
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);

        final usermodel = await ref.read(getMeProvider.future);
        switch (usermodel) {
          case UserModelAdm():
            state = state.copyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.copyWith(status: LoginStateStatus.employeeLogin);
        }
        break;
      case Failure(exception: ServiceExceptions(:final message)):
        state = state.copyWith(
          status: LoginStateStatus.error,
          errorMessage: () => message,
        );
    }
    loaderHandle.close();
  }
}
