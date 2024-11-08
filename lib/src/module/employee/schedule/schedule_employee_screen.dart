import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/module/employee/schedule/appointment_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleEmployeeScreen extends StatelessWidget {
  const ScheduleEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          const Text(
            'Nome e sobre nome',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Expanded(
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
                                    calendarTapDetails.date ?? DateTime.now(),
                                  )}',
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
              allowViewNavigation: true,
              view: CalendarView.day,
              showNavigationArrow: true,
              todayHighlightColor: ColorsConstants.brow,
              showDatePickerButton: true,
              showTodayButton: true,
              dataSource: AppointmentDs(),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                return Container(
                  decoration: BoxDecoration(
                    color: ColorsConstants.brow,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                        calendarAppointmentDetails.appointments.first.subject),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
