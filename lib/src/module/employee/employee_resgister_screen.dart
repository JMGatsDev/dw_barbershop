import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:dw_barbershop/src/module/employee/employee_register_state.dart';
import 'package:dw_barbershop/src/module/employee/employee_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/widgets/avatar_widget.dart';

class EmployeeResgisterScreen extends ConsumerStatefulWidget {
  const EmployeeResgisterScreen({super.key});

  @override
  ConsumerState<EmployeeResgisterScreen> createState() =>
      _EmployeeResgisterScreenState();
}

class _EmployeeResgisterScreenState
    extends ConsumerState<EmployeeResgisterScreen> {
  bool registerAdm = false;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com Sucesso', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar página', error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar página'),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (barberShopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barberShopModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: registerAdm,
                            onChanged: (value) {
                              setState(() {
                                registerAdm = !registerAdm;
                                employeeRegisterVm.setRegisterAdm(registerAdm);
                              });
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Sou Administrador e quero me cadastrar como colaborador',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      Offstage(
                        offstage: registerAdm,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration:
                                  const InputDecoration(label: Text('Nome')),
                              validator: registerAdm
                                  ? null
                                  : Validatorless.required(
                                      'O nome é obrigatório'),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration:
                                  const InputDecoration(label: Text('E-mail')),
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple(
                                      [
                                        Validatorless.email('E-mail inválido'),
                                        Validatorless.required(
                                            'O e-mail é obrigatório'),
                                      ],
                                    ),
                            ),
                            SizedBox(
                              height: size.height * 0.025,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(label: Text('Senha')),
                              validator: registerAdm
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'A senha Obrigatória'),
                                      Validatorless.min(
                                        6,
                                        'A senha deve pelo menos 6 caracteres',
                                      )
                                    ]),
                            ),
                          ],
                        ),
                      ),
                      WeekdaysPanel(
                        enableDays: openingDays,
                        onPressed: employeeRegisterVm.addOrRemoveWorkDays,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      HoursPanel(
                        enableTimes: openingHours,
                        startTime: 6,
                        endTime: 23,
                        onHourPressed: employeeRegisterVm.addOrRemoveWorkHours,
                      ),
                      SizedBox(
                        height: size.height * 0.025,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56)),
                          onPressed: () {
                            switch (formKey.currentState?.validate()) {
                              case false || null:
                                Messages.showError(
                                    'Existem campos Inválídos', context);
                              case true:
                                final EmployeeRegisterState(
                                  workDays: List(isEmpty: hasWorkDays),
                                  workHours: List(isEmpty: hasWorkHours)
                                ) = ref.watch(employeeRegisterVmProvider);

                                if (hasWorkDays || hasWorkHours) {
                                  Messages.showError(
                                      'Por favor selecione os dias das semanas e horarios de atendimento',
                                      context);
                                  return;
                                }
                                final name = nameController.text;
                                final email = emailController.text;
                                final password = passwordController.text;

                                employeeRegisterVm.register(
                                    name: name,
                                    email: email,
                                    password: password);
                            }
                          },
                          child: const Text('Cadastrar Colaborador'))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
