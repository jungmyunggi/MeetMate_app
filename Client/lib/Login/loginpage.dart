import 'package:app_1/Login/registration.dart';
import 'package:app_1/Page/Home/homepage.dart';
import 'package:app_1/Global/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final ID = TextEditingController();
  final Password = TextEditingController();
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('존재하지 않는 회원입니다.'),
            content: const Text('아이디 또는 비밀번호를 확인해 주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  } // 아이디 또는 비밀번호 틀릴 시 나오는 경고창

  void login() {
    if (ID.text.isEmpty || Password.text.isEmpty) {
      print(ID.text);
      print(Password.text);
      _showDialog(context); // 완료 못하면 경고창
    } // 로그인 시 빈 필드가 존재하는지  검사

    final options = {
      "uid": ID.text,
      "password": Password.text,
    }; // 필드에 있는 정보 서버로 전송
    print(options);
    dio
        .post("$baseUrl/member/login", data: options)
        .then((result) async => {
              print(result),
              if (result.data["uid"].isNotEmpty)
                {
        setState(() {
          user.User_ID = result.data["uid"];
          user.User_PassWord = result.data["password"];
          user.User_Nic = result.data["nickname"];
          user.User_Local = result.data["local"];
          user.User_Name = result.data["name"];
          user.User_Hobby = result.data["hobby"];
          user.User_type = result.data["company_check"];
        }), // 서버에서 아이디, 비밀번호 검사 후 결과 값으로 사용자의 정보를 반환 -> 반환된 정보를 만들어 둔 User 객체에 저장
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),// 완료 후 Home으로 페이지 전환
                  ),
               }
              else{
                _showDialog(context) // 완료 못하면 경고창
              }
            })
        .catchError((error) => {
              print(error),
            });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      }, // 뒤로가기 못하게 막는 함수
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(''),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(bottom: 50)),
                Image.asset(
                  'assets/logo.jpg',
                  scale: 1.5,
                ), // 로고 띄우기

                Padding(padding: EdgeInsets.all(20)),
                // Align(
                //   child: Text(
                //     'Login',
                //     style: TextStyle(fontSize: 30),
                //   ),
                //   alignment: Alignment(-0.8, 0),
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: TextField(
                      controller: ID,
                      decoration: InputDecoration(
                        labelText: '아이디',
                        labelStyle: TextStyle(fontSize: 25),
                        contentPadding: EdgeInsets.symmetric(vertical: -2),
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 35)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  child: TextField(
                    controller: Password,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(fontSize: 25),
                      contentPadding: EdgeInsets.symmetric(vertical: -2),
                    ),
                    style: TextStyle(fontSize: 20),
                    obscureText: true,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 70)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        events.clear();
                        login();
                      },
                      child: Text(
                        '로그인',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                )

                // TextButton(
                //     onPressed: () {
                //       Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         return Registration();
                //       }));
                //     }, // 회원가입 버튼
                //     child: Text('회원가입')),
                // ElevatedButton(
                //     onPressed: () {
                //       events.clear();
                //       login();
                //     },
                //     child: Text('로그인')), // 로그인 버튼
              ],
            ),
          ),
        ),
      ),
    );
  }
}