import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  @override
  List<dynamic>? get appointments => [
        Appointment(
          subject: 'João ',
          startTime: DateTime.now(),
          endTime: DateTime.now().add(
            const Duration(hours: 1),
          ),
        ),
        Appointment(
          subject: 'Marcos',
          startTime: DateTime.now().add(const Duration(hours: 2)),
          endTime: DateTime.now().add(
            const Duration(hours: 3),
          ),
        )
      ];
}
