import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Global/global.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState(){
    super.initState();
    events.clear();
    _getEvent();
    print(eventtext);

  }
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  List<String> eventtext = [];

  void _getEvent() {
    List<Event> eventday = _getEventsForDay(_focusedDay);
    setState(() {
      if (eventday.isNotEmpty) {
        eventtext = eventday.map((event) {
          List<String> s = event.text.split(" ");
          String time = s[1]; // 이벤트에서 시간 가져오기
          String content = s[0]; // 이벤트에서 내용 가져오기
          String local = s[2]; // 이벤트에서 위치 가져오기
          return "$time $content $local";
        }).toList();
      } else {
        eventtext = ["등록된 일정이 없습니다"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('일정'),
      actions: [
        ElevatedButton(
          onPressed: () {
            _getEvent();
          },
          child: Text('새로고침'),
        )
      ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2050, 12, 30),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _getEvent();
                });
              },
              eventLoader: _getEventsForDay,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*2,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  DataTable(
                    columns: [
                      DataColumn(label: Text('시간')),
                      DataColumn(label: Text('내용')),
                      DataColumn(label: Text('위치')),
                    ],
                    rows: eventtext.map((text) {
                      List<String> splitText = text.split(" ");
                      String time = splitText[0];
                      String content = splitText[1];
                      String local = splitText[2];
                      return DataRow(cells: [
                        DataCell(Text(time)),
                        DataCell(Text(content)),
                        DataCell(Text(local)),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}