import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/home/employee/home_employee_provider.dart';
import 'package:dw_barbershop/src/module/home/widget/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEmployeeScreen extends ConsumerWidget {
  const HomeEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: userModelAsync.when(
        error: (e, s) => const Center(
          child: Text('Erro ao carregar pagina'),
        ),
        loading: () => const BarbershopLoader(),
        data: (user) {
          final UserModel(:name, :id) = user;
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const AvatarWidget(
                        hideUploadingButton: true,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        width: size.width * 0.7,
                        height: size.height * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorsConstants.grey)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(builder: (context, ref, child) {
                              final totalAsync =
                                  ref.watch(getTotalSchedulesTodayProvider(id));
                              return totalAsync.when(
                                error: (e, s) {
                                  return const Center(
                                    child: Text(
                                        'Erro ao carregar total de agendamentos'),
                                  );
                                },
                                skipLoadingOnRefresh: false,
                                loading: () => const BarbershopLoader(),
                                data: (data) {
                                  return Text(
                                    "${totalAsync.value}",
                                    style: const TextStyle(
                                      color: ColorsConstants.brow,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 32,
                                    ),
                                  );
                                },
                              );
                            }),
                            const Text(
                              'Hoje',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed('/schedule', arguments: user);
                          ref.invalidate(getTotalSchedulesTodayProvider);
                        },
                        child: const Text('Agendar Cliente'),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/employee/schedule', arguments: user);
                        },
                        child: const Text('ver agenda'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
