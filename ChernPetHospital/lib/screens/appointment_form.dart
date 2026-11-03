import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:event/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  State<AppointmentForm> createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  List Lst_meet = [];
  DateTime? _datetime = DateTime.now().add(const Duration(days: -60));
  DateTime? _datetime2 = DateTime.now().add(const Duration(days: 60));
  final GlobalKey<TooltipState> _toolTipKey = GlobalKey<TooltipState>();

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    Color meet_color = Colors.blue;

    // final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(
    //   Meeting('นัดตัดขน', startTime, endTime, const Color(0xFF0F8644), false),
    // );
    // meetings.add(
    //   Meeting(
    //     'พบแพทย์',
    //     startTime.add(const Duration(days: 2)),
    //     endTime.add(const Duration(days: 2)),
    //     const Color(0xFF0F8644),
    //     false,
    //   ),
    // );

    for (int index = 0; index < Lst_meet.length; index++) {
      if (Lst_meet[index]["meet_type"] == 'พบแพทย์') {
        meet_color = Colors.red;
      } else if (Lst_meet[index]["meet_type"] == 'แอดมิท') {
        meet_color = Colors.pink;
      } else if (Lst_meet[index]["meet_type"] == 'อาบน้ำตัดขน') {
        meet_color = Colors.blue;
      } else if (Lst_meet[index]["meet_type"] == 'ฝากเลี้ยง') {
        meet_color = Colors.deepPurple;
      } else if (Lst_meet[index]["meet_type"] == 'อื่นๆ') {
        meet_color = Colors.teal;
      }

      meetings.add(
        Meeting(
          Lst_meet[index]["meet_type"],
          'Pet : ' +
              Lst_meet[index]["pet_name"] +
              ' \n' +
              'Client : ' +
              Lst_meet[index]["cus_name"] +
              ' Tel.' +
              Lst_meet[index]["cus_tel"] +
              ' \n' +
              'Detail : ' +
              Lst_meet[index]["meet_detail"],
          DateTime.parse(Lst_meet[index]["meet_time_start"]),
          DateTime.parse(Lst_meet[index]["meet_time_end"]),
          meet_color,
          false,
        ),
      );
    }

    return meetings;
  }

  Future<void> _loadMeet() async {
    String url = "${root_url}selectmeet.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'meet_date':
              '${_datetime!.year}-${_datetime!.month}-${_datetime!.day}',
          'meet_date2':
              '${_datetime2!.year}-${_datetime2!.month}-${_datetime2!.day}',
        },
      ),
    );
    if (Response.statusCode == 200) {
      setState(() {
        Lst_meet = json.decode(Response.body);
      });
    }
  }

  // void calendarTapped(CalendarTapDetails details) {
  //   if (details.targetElement == CalendarElement.appointment) {
  //     // ดึงข้อมูลนัดหมายแรกที่ถูกแตะ
  //     final Meeting appointment = details.appointments![0];

  //     print('หัวข้อ: ${appointment.subject}');
  //     print('รายการ: ${appointment.eventName}');
  //     print('เริ่มเมื่อ: ${appointment.from}');
  //   }

  //   //  else if (details.targetElement == CalendarElement.calendarCell) {
  //   //   print('วันที่เลือกคือ: ${details.date}');
  //   // }
  // }

  void calendarTapped(
    BuildContext context,
    CalendarTapDetails calendarTapDetails,
  ) {
    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      final Meeting appointment = calendarTapDetails.appointments![0];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EventView(eventData: appointment.eventName),
        ),
      );
    }
  }

  void initState() {
    super.initState();

    _loadMeet();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            "Appointment",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          // actions: const [],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Day'),
              Tab(text: 'Week'),
              Tab(text: 'Month'),
              //    Tab(text: 'Schedule'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Center(
              child: SfCalendar(
                view: CalendarView.day,
                onTap: (details) => calendarTapped(context, details),

                // (CalendarTapDetails details) {
                //   if (details.targetElement == CalendarElement.appointment) {
                //     final Meeting appointment = details.appointments![0];

                //     //  print('รายการ: ${appointment.eventName}');
                //   }
                // },
                dataSource: MeetingDataSource(_getDataSource()),
              ),
            ),

            Center(
              child: SfCalendar(
                view: CalendarView.week,
                onTap: (details) => calendarTapped(context, details),

                // (CalendarTapDetails details) {
                //   if (details.targetElement == CalendarElement.appointment) {
                //     final Meeting appointment = details.appointments![0];

                //     //  print('รายการ: ${appointment.eventName}');
                //   }
                // },
                dataSource: MeetingDataSource(_getDataSource()),
              ),
            ),

            Center(
              child: SfCalendar(
                view: CalendarView.month,
                onTap: (details) => calendarTapped(context, details),

                //  (CalendarTapDetails details) {
                //   if (details.targetElement == CalendarElement.appointment) {
                //     final Meeting appointment = details.appointments![0];

                //     //  print('รายการ: ${appointment.eventName}');
                //   }
                // },
                dataSource: MeetingDataSource(_getDataSource()),
                monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  agendaViewHeight: 200,
                  agendaItemHeight: 70,
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                ),
              ),
            ),

            // Center(
            //   child: SfCalendar(
            //     view: CalendarView.schedule,
            //     dataSource: MeetingDataSource(_getDataSource()),
            //     monthViewSettings: const MonthViewSettings(

            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
    this.subject,
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  );

  String subject;

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

class EventView extends StatelessWidget {
  final String eventData;

  const EventView({required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Appointment Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${eventData}'),
            SizedBox(height: 10),
            //    Text('Event : ${eventData.description}'),
          ],
        ),
      ),
    );
  }
}
