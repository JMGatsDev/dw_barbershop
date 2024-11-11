import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/module/auth/login/login_screen.dart';
import 'package:dw_barbershop/src/module/auth/register/barbershop_register/barbershop_register_screen.dart';
import 'package:dw_barbershop/src/module/auth/register/user_register/user_register_screen.dart';
import 'package:dw_barbershop/src/module/employee/employee_resgister_screen.dart';
import 'package:dw_barbershop/src/module/employee/schedule/schedule_employee_screen.dart';
import 'package:dw_barbershop/src/module/home/adm/home_adm_screen.dart';
import 'package:dw_barbershop/src/module/schedule/schedule_screen.dart';
import 'package:dw_barbershop/src/module/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
              '/auth/register/barbershop': (_) => BarbershopRegisterScreen(),
              '/auth/register/user': (_) => const UserRegisterScreen(),
              '/home/adm': (_) => const HomeAdmScreen(),
              '/home/employee': (_) => const Center(child: Text('Emplyee')),
              '/employee/register': (_) => const EmployeeResgisterScreen(),
              '/schedule': (_) => const Center(child: ScheduleScreen()),
              '/employee/schedule': (_) => const ScheduleEmployeeScreen()
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale("pt", "BR")],
            locale: const Locale("pt", "BR"),
          );
        });
  }
}
