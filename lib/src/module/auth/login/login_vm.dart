import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exceptions.dart';
import 'package:dw_barbershop/src/core/funcionalProgram/either.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
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
