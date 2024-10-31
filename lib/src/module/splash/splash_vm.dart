import 'package:dw_barbershop/src/core/constants/local_storege_keys.dart';
import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_vm.g.dart';

enum SplashState { initial, login, loggedADM, loggedEmployee, error }

@riverpod
class SplashVm extends _$SplashVm {
  Future<SplashState> build() async {
    final token = await SharedPreferences.getInstance();
    if (token.containsKey(LocalStoregeKeys.accessToken)) {
      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);
      final userModel = await ref.watch(getMeProvider.future);
      try {
        return switch (userModel) {
          UserModelAdm() => SplashState.loggedADM,
          UserModelEmployee() => SplashState.loggedEmployee,
        };
      } catch (e) {
        return SplashState.login;
      }
    }
    return SplashState.login;
  }
}
