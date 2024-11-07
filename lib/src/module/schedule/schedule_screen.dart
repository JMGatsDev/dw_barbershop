import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helpers.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/schedule/schedule_state.dart';
import 'package:dw_barbershop/src/module/schedule/schedule_vm.dart';
import 'package:dw_barbershop/src/module/schedule/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/helpers/messages.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final formKey = GlobalKey<FormState>();
  final nameClienteController = TextEditingController();
  final dateController = TextEditingController();
  var dateFormat = DateFormat('dd/MM/yyyy');

  bool showCalendar = false;
  @override
  void dispose() {
    nameClienteController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    final scheduleVm = ref.watch(scheduleVmProvider.notifier);
    final employeeData = switch (userModel) {
      UserModelAdm(:final workDays, :final workHours) => (
          workDays: workDays!,
          workHours: workHours!
        ),
      UserModelEmployee(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours
        ),
    };

     ref.listen(scheduleVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case ScheduleStateStatus.initial:
          break;
        case ScheduleStateStatus.success:
          Messages.showSuccess("Cliente agendado com sucesso", context);
          Navigator.of(context).pop();
        case ScheduleStateStatus.error:
          Messages.showError("Erro ao registar agendamento", context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Center(
              child: Column(
            children: [
              const AvatarWidget(
                hideUploadingButton: true,
              ),
              SizedBox(
                height: size.height * 0.035,
              ),
              Text(
                userModel.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              TextFormField(
                validator: Validatorless.required('Cliente Obrigatório'),
                controller: nameClienteController,
                decoration: const InputDecoration(
                  label: Text('Cliente'),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              TextFormField(
                validator:
                    Validatorless.required('Selecione a data do agendamento'),
                controller: dateController,
                readOnly: true,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    BarbershopIcons.calendar,
                    color: ColorsConstants.brow,
                    size: 18,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText: 'Selecione uma data',
                  label: Text('Selecione uma data'),
                ),
                onTap: () {
                  setState(() {
                    showCalendar = true;
                  });
                  context.unFocus();
                },
              ),
              Offstage(
                offstage: !showCalendar,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ScheduleCalendar(
                      workDays: employeeData.workDays,
                      cancelPressed: () {
                        setState(() {
                          showCalendar = false;
                        });
                      },
                      okPressed: (DateTime value) {
                        setState(() {
                          dateController.text = dateFormat.format(value);
                          scheduleVm.dateSelect(value);
                          showCalendar = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              HoursPanel.singleSelection(
                startTime: 6,
                endTime: 23,
                onHourPressed: scheduleVm.hourSelect,
                enableTimes: employeeData.workHours,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ElevatedButton(
                child: const Text('Agendar'),
                onPressed: () {
                  switch (formKey.currentState?.validate()) {
                    case null || false:
                      Messages.showError('Dados incompletos', context);
                    case true:
                      final hourSelected = ref.watch(
                        scheduleVmProvider
                            .select((state) => state.scheduleHour != null),
                      );
                      if (hourSelected) {
                        scheduleVm.register(
                            usermodel: userModel,
                            clientName: nameClienteController.text);
                      } else {
                        Messages.showError(
                            'Por favor selecione o horario de atendimento',
                            context);
                      }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              )
            ],
          )),
        ),
      )),
    );
  }
}
