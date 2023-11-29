import 'package:app_1/AppBar/bottomappbar.dart';
import 'package:flutter/material.dart';
import 'package:app_1/Page/Around/findaround.dart';
import 'package:app_1/Page/Home/homepage.dart';
import 'package:app_1/Page/Info/myinfopage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio =Dio(); // http통신을 위한 Dio객체 생성
String baseUrl = "https://fond-stinkbug-simply.ngrok-free.app"; // 서버 baseUrl

class User{ // 유저 정보 저장
  late String User_Local ='';
  late String User_Name='';
  late String User_Hobby='';
  late String User_ID='';
  late String User_PassWord='';
  late String User_Nic='';
  late bool User_type;

  void set_Nic(String N){
    User_Nic =N;
  }
  void set_Local(String L){
    User_Local =L;
  }
  void set_Name(String N){
    User_Name = N;
  }
  void set_Hobby(String H){
    User_Hobby=H;
  }
  void set_ID(String I){
    User_ID = I;
  }
  void set_PassWord(String P){
    User_PassWord=P;
  }
  void set_Type(bool t){
    User_type=t;
  }
  String get_Nic(){
    return User_Nic;
  }
  String get_Local(){
   return User_Local;
  }
  String get_Name(){
    return User_Name;
  }
  String get_Hobby(){
    return User_Hobby;
  }
  String get_ID(){
    return User_ID;
  }
  String get_PassWord(){
    return User_PassWord;
  }
  bool get_Type(){
    return User_type;
  }

}
refresh() { // 새로고침시 나오는 알림창
  showDialog(
    context: navigatorContext,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: AlertDialog(
          content: Text('새로고침 성공'),
          actions: <Widget>[
            Container(
              width: 1,
              height: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(''),
              ),
            ),
          ],
        ),
      );
    },
  );
}
late Future<List<Map<String, dynamic>>> futureDataList; // 글 정보를 모두 저장하는 변수
 // 글 정보를 리스트화 해서 출력 가능한 상태로 저장하는 변수
late BuildContext navigatorContext; // 현재 사용자가 보고있는 페이지에 대한 정보 저장하는 변수
late List<Map<String, dynamic>> reviewList; // 글에 달린 댓글을 저장하는 변수
User user = User(); // 유저 객체 생성

late List<dynamic> a;
class Event {
  String text = '';

  Event(this.text);
}
List<dynamic> invit = [];
Map<DateTime, List<Event>> events = {
  DateTime.utc(2000, 01, 01): [
    Event('aaa aaa aaa'),
  ],
};






