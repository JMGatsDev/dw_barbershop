import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:dw_barbershop/src/module/employee/employee_register_vm.dart';
import 'package:dw_barbershop/src/module/employee/schedule/appointment_ds.dart';
import 'package:dw_barbershop/src/module/employee/schedule/employee_schedule_vm.dart';
import 'package:dw_barbershop/src/module/schedule/schedule_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleEmployeeScreen extends ConsumerStatefulWidget {
  const ScheduleEmployeeScreen({super.key});

  @override
  ConsumerState<ScheduleEmployeeScreen> createState() =>
      _ScheduleEmployeeScreenState();
}

class _ScheduleEmployeeScreenState
    extends ConsumerState<ScheduleEmployeeScreen> {
  late DateTime dateSelected;
  var ignoreFirstLoading = true;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final scheduleAsync =
        ref.watch(employeeScheduleVmProvider(userId, dateSelected));

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          scheduleAsync.when(
            loading: () => const BarbershopLoader(),
            error: (e, s) {
              log('Erro ao Carregar agendamentos', error: e, stackTrace: s);
              return const Center(
                child: Text('Erro ao carergar pagina'),
              );
            },
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.appointments != null &&
                        calendarTapDetails.appointments!.isNotEmpty) {
                      final dateFormart = DateFormat('dd/MM/yyyy HH:mm:ss');
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: size.height * 0.2,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cliente : ${calendarTapDetails.appointments?.first.subject}',
                                    ),
                                    Text(
                                      'Horário : ${dateFormart.format(
                                        calendarTapDetails.date ??
                                            DateTime.now(),
                                      )}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  },
                  onViewChanged: (ViewChangedDetails) {
                    if (ignoreFirstLoading) {
                      ignoreFirstLoading = false;
                      return;
                    }
                    ref
                        .read(employeeScheduleVmProvider(userId, dateSelected)
                            .notifier)
                        .changrDate(
                          userId,
                          ViewChangedDetails.visibleDates.first,
                        );
                  },
                  allowViewNavigation: true,
                  view: CalendarView.day,
                  showNavigationArrow: true,
                  todayHighlightColor: ColorsConstants.brow,
                  showDatePickerButton: true,
                  showTodayButton: true,
                  dataSource: AppointmentDs(schedules: schedules),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
