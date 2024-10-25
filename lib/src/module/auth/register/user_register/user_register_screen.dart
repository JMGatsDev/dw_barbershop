import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/module/auth/login/login_screen.dart';
import 'package:dw_barbershop/src/module/auth/register/user_register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/form_helpers.dart';

class UserRegisterScreen extends ConsumerStatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserRegisterScreenState();
}

class _UserRegisterScreenState extends ConsumerState<UserRegisterScreen> {
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
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(
      userRegisterVmProvider,
      (previous, state) {
        switch (state) {
          case UserRegisterStateStatus.initial:
            break;
          case UserRegisterStateStatus.success:
          Navigator.of(context)
                .pushNamedAndRemoveUntil('/auth/register/barbershop', (route) => false);
          case UserRegisterStateStatus.error:
            Messages.showError('Erro ao Registrar Administrador', context);
            break;
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
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
                  height: MediaQuery.of(context).size.height * 0.035,
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
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  controller: passwordController,
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatoria'),
                    Validatorless.min(
                        6, 'Senha deve ter no minimo 6 caracteres')
                  ]),
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatoria'),
                    Validatorless.compare(passwordController, 'Senha diferente')
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Confirmar senha'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                          MediaQuery.of(context).size.height * 0.065),
                    ),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Messages.showError('Formulário Invalido', context);
                        case true:
                          userRegisterVm.register(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text);
                      }
                    },
                    child: Text('Criar Conta'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
