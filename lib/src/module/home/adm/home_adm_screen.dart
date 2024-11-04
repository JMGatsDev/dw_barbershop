import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/module/home/adm/home_adm_state.dart';
import 'package:dw_barbershop/src/module/home/adm/home_adm_vm.dart';
import 'package:dw_barbershop/src/module/home/adm/widgets/home_employee_tile.dart';
import 'package:dw_barbershop/src/module/home/widget/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmScreen extends ConsumerWidget {
  const HomeAdmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(
                  showFilter: true,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => HomeEmployeeTile(
                          employee: data.employee[index],
                        ),
                    childCount: data.employee.length),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar Colaboradores',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar dados'),
          );
        },
        loading: () {
          return const BarbershopLoader();
        },
      ),
    );
  }
}
