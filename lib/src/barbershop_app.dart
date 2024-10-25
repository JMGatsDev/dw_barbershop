import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/module/auth/login/login_screen.dart';
import 'package:dw_barbershop/src/module/auth/register/user_register/user_register_screen.dart';
import 'package:dw_barbershop/src/module/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BarbershopLoader(),
        builder: (AsyncNavigatorObserver) {
          return MaterialApp(
            theme: BarbershopTheme.themeData,
            title: 'Dw Barbershop',
            navigatorKey: BarbershopNavGlobalKey.instance.navKey,
            navigatorObservers: [AsyncNavigatorObserver],
            routes: {
              '/': (_) => const SplashScreen(),
              '/auth/login': (_) => const LoginScreen(),
              '/auth/register/barbershop': (_) =>
                  const Center(child: Text('Barbershop')),
              '/auth/register/user': (_) => const UserRegisterScreen(),
              '/home/adm': (_) => const Center(child: Text('ADM')),
              '/home/employee': (_) => const Center(child: Text('Emplyee')),
            },
          );
        });
  }
}
