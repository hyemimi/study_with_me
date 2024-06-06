import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/models/userSchedule.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  late List<UserScheduleModel> eventScheduleList = [];
  var user_id = Provider.of<UserProvider>(
          CandyGlobalVariable.naviagatorState.currentState!.context)
      .user_id;

  Map<DateTime, List> _eventsList = {}; // 일정

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 100000 + key.year;
  }

  void waitForEvents() async {
    eventScheduleList = await ApiService().getAllSchedule(user_id);
    setState(() {
      for (var date in eventScheduleList) {
        _eventsList[DateTime.parse(date.time).add(Duration(hours: 9))] = [
          '${date.title}\n${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(date.time).add(Duration(hours: 9)))} ~ ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(date.time).add(Duration(hours: 9, minutes: date.during)))}\n${date.location}'
        ];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForEvents();

    _selectedDay = _focusedDay;
    print(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);

    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    return Scaffold(
        appBar: AppBar(title: Text('나의 캘린더')),
        body: Column(children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMMMd(locale).format(date),
              titleTextStyle:
                  const TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
            firstDay: DateTime.utc(2021, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            eventLoader: getEventForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              todayDecoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              markerSize: 20.0,
              markerDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/logoImage.png')),
                  shape: BoxShape.circle),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          ListView(
            shrinkWrap: true,
            children: getEventForDay(_selectedDay!)
                .map((event) => Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xffF7ECB4).withOpacity(0.24),
                      border: Border.all(color: Color(0xffF7ECB4), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text(event.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                    )))
                .toList(),
          )
        ]));
  }
}
