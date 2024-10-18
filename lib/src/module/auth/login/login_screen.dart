import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/module/auth/login/login_state.dart';
import 'package:dw_barbershop/src/module/auth/login/login_vm.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(
      loginVmProvider,
      (previous, state) {
        switch (state) {
          case LoginState(status: LoginStateStatus.initial):
            break;
          case LoginState(status: LoginStateStatus.error, :final errorMessage?):
            Messages.showError(errorMessage, context);
          case LoginState(status: LoginStateStatus.error):
            Messages.showError('Erro ao realizar login', context);
            case LoginState(status: LoginStateStatus.admLogin):
            break;
            case LoginState(status: LoginStateStatus.employeeLogin):
            break;
        }
      },
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.5,
              fit: BoxFit.cover,
              image: AssetImage(
                ImageConstants.backgroundChair,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstants.imageLogo,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          TextFormField(
                            controller: emailController,
                            onTapOutside: (_) => unFocus(context),
                            validator: Validatorless.multiple([
                              Validatorless.required('E-mail obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ]),
                            decoration: const InputDecoration(
                              label: Text(
                                'E-mail',
                              ),
                              hintText: 'E-mail',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.035,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(6,
                                  'Senha deve conter pelo menos 6 caracteres'),
                            ]),
                            onTapOutside: (_) => unFocus(context),
                            decoration: const InputDecoration(
                              label: Text(
                                'Senha',
                              ),
                              hintText: 'Senha',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          const Text(
                            'Esqueceu a senha ?',
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorsConstants.brow,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
                          ),
                          ElevatedButton(
                            child: const Text('Acessar'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(
                                MediaQuery.of(context).size.height * 0.065,
                              ),
                            ),
                            onPressed: () {
                              switch (formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                      'Campos inválidos', context);
                                  break;
                                case true:
                                  login(emailController.text,
                                      passwordController.text);
                              }
                            },
                          )
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
