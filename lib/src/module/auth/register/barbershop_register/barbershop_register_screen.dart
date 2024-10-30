import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/module/auth/register/barbershop_register/barbershop_register_state.dart';
import 'package:dw_barbershop/src/module/auth/register/barbershop_register/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/form_helpers.dart';
import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/weekdays_panel.dart';

class BarbershopRegisterScreen extends ConsumerStatefulWidget {
  BarbershopRegisterScreen({super.key});

  @override
  ConsumerState<BarbershopRegisterScreen> createState() =>
      _BarbershopRegisterScreenState();
}

class _BarbershopRegisterScreenState
    extends ConsumerState<BarbershopRegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barberShopRegisterVm =
        ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.success:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
        case BarbershopRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar a barbearia', context);
      }
    });

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register barbershop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.035,
                ),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                  validator: Validatorless.required('Nome Obrigatório'),
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  controller: emailController,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required('E-mail obrigatório'),
                      Validatorless.email('E-mail invalido')
                    ],
                  ),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                WeekdaysPanel(
                  onPressed: (value) {
                    barberShopRegisterVm.addOrRemoveOpenDays(value);
                  },
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                HoursPanel(
                  onHourPressed: (int value) {
                    barberShopRegisterVm.addOrRemoveOpenHours(value);
                  },
                  startTime: 6,
                  endTime: 23,
                ),
                SizedBox(
                  height: height * 0.035,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(height * 0.065),
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case false || null:
                          Messages.showError('Formulario Invalido', context);
                        case true:
                          barberShopRegisterVm.registerBarbersop(
                              nameController.text, emailController.text);
                      }
                    },
                    child: Text('Criar barbearia'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
