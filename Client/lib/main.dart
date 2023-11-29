import 'package:app_1/Login/loginpage.dart';
import 'package:app_1/Login/registlocal.dart';
import 'package:app_1/Page/Admin/adminpage.dart';
import 'package:app_1/Page/Calender/calender.dart';
import 'package:app_1/Page/Home/homepage.dart';
import 'package:app_1/Page/Info/myinfopage.dart';
import 'package:app_1/Page/Util/writepage.dart';
import 'package:app_1/testpage.dart';
import 'package:flutter/material.dart';

import 'Login/registhobbypage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Login()
    );

  }
}

