import 'dart:ffi';

import 'package:app_1/Page/Calender/calender.dart';
import 'package:app_1/Global/global.dart';
import 'package:flutter/material.dart';
import 'package:app_1/Page/Around/findaround.dart';
import 'package:app_1/Page/Info/myinfopage.dart';
import 'package:app_1/Page/Home/homepage.dart';

import '../Page/Category/category.dart';

final Widget BtmAppBar = BottomAppBar(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: ElevatedButton(
            onPressed: () {
              _CurrentContext = 'Home';
              Navigator.of(navigatorContext).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Home(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                Text(
                  '홈',
                  style: TextStyle(fontSize: 7),
                )
              ],
            )),
      ), // 홈 버튼
      Expanded(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(navigatorContext).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Category(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.storage),
                Text('카테고리', style: TextStyle(fontSize: 7))
              ],
            )),
      ), // 카테고리 버튼
      Expanded(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(navigatorContext).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Around(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map),
                Text('주변취미', style: TextStyle(fontSize: 7))
              ],
            )),
      ), // 주변취미 버튼
      Expanded(
        child: ElevatedButton(
            onPressed: () {
              final options = {
                "nickname": user.User_Nic,
              };
              dio.post("$baseUrl/calendar/list", data: options).then((value) {

                  for(var p in value.data){
                    DateTime targetDate = parseKoreanDateTimeString(p['local']);
                    Event newEvent = Event(p['title']+" "+parseTimeString(p['local'])+" "+p['meetTime']);
                    List<Event> targetEventList = events[targetDate] ?? [];
                    targetEventList.add(newEvent);
                    events[targetDate] = targetEventList;
                  }
              });
              _CurrentContext = 'Info';
              Navigator.of(navigatorContext).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Calender(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.calendar_month_rounded),
                Text('일정', style: TextStyle(fontSize: 7))
              ],
            )),
      ), // 캘린더 버튼
      Expanded(
        child: ElevatedButton(
            onPressed: () {
              _CurrentContext = 'Info';
              Navigator.of(navigatorContext).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Info(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.face),
                Text('내 정보', style: TextStyle(fontSize: 7))
              ],
            )),
      ), // 내정보 버튼
    ],
  ),
);

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String _CurrentContext = '';

initNavigatorContext(BuildContext context) {
  navigatorContext = context;
}

setNavigatorContext(BuildContext context) {
  if (context.widget.toString() != _CurrentContext) {
    navigatorContext = context;
  }
}
DateTime parseKoreanDateTimeString(String dateString) {
  // '23년11월12일12시30분' 형식의 문자열을 DateTime으로 변환
  List<String> components = dateString.split(RegExp(r'[년월일시분]'));
  print(components);
  int year = int.parse(components.elementAt(0))+2000;
  int month = int.parse(components.elementAt(1));
  int day = int.parse(components.elementAt(2));
  return DateTime.utc(year, month, day);
}
String parseTimeString(String dateString) {
  // '23년11월12일12시30분' 형식의 문자열을 DateTime으로 변환
  List<String> components = dateString.split(RegExp(r'[년월일시분]'));
  String hour = (components.elementAt(3));
  String minute = (components.elementAt(4));

  return (hour+"시"+minute+"분");
}
// 페이지 바텀앱바
