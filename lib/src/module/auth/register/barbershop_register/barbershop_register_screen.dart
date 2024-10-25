import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/form_helpers.dart';
import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/weekdays_panel.dart';

class BarbershopRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  BarbershopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const WeekdaysPanel(),
                SizedBox(
                  height: height * 0.035,
                ),
                HoursPanel(),
                SizedBox(
                  height: height * 0.035,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(height * 0.065),
                    ),
                    onPressed: () {},
                    child: Text('Criar Conta'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
