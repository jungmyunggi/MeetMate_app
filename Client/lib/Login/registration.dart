import 'package:app_1/Login/registhobbypage.dart';
import 'package:app_1/Global/global.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final ID_Controller = TextEditingController();
  final Password_Controller = TextEditingController();
  final Name_Controller = TextEditingController();
  final Nicname_Controller = TextEditingController();
  bool id_check = false;
  bool nic_check = false;
  bool is_company = false;
 // => 전부 입력 받을 때 사용하는 컨트롤러
  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('입력 필요'),
            content: const Text('입력되지 않은 내용이 있습니다.   \n모든 항목을 입력해주세요.',
              style: TextStyle(fontSize: 15),
            ),
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
  } // 빈 필드가 있을때 띄우는 경고창

  _check_available_id_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(''),
            content: const Text('아이디/닉네임의 중복 확인이 필요합니다.',
              style: TextStyle(fontSize: 18),
            ),
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
  } // 중복 체크를 하지 않았을 때 나오는 경고창

  _available_id_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(''),
            content: const Text('사용 가능한 아이디 입니다.'),
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
  } // 사용 가능한 아이디일 때 나오는 알림창

  _available_nic_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(''),
            content: const Text('사용 가능한 닉네임 입니다.'),
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
  } // 사용 가능한 닉네임일 때 나오는 알림창

  _refuse_id_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(''),
            content: const Text('사용할 수 없는 아이디 입니다.'),
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
  }

  _refuse_nic_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text(''),
            content: const Text('중복된 닉네임 입니다.'),
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
  }

  void _checkd_id_uplication() { // id 중복 체크
    final options = {"uid": ID_Controller.text};
    print(ID_Controller.text);
    dio.post("$baseUrl/member/id_check", data: options).then((result) async => {
          print(result.data.toString()),
          if (result.data)
            {
              _available_id_Dialog(context),
              setState(() {
                if(!id_check)
                id_check = !id_check;
              })
            }
          else
            {
              _refuse_id_Dialog(context),
            }
        });
  }

  void _checkd_nic_uplication() { // 닉네임 중복 체크
    final options = {"nickname": Nicname_Controller.text};
    dio.post("$baseUrl/member/nickname_check", data: options).then((result) async => {
          print(Nicname_Controller.text),
          print(result.data.toString()),
          if (result.data)
            {
              _available_nic_Dialog(context),
              setState(() {
                if(!nic_check)
                nic_check = !nic_check;
              })
            }
          else
            {
              _refuse_nic_Dialog(context),
            }
        });
  }


  Color fieldColor = Color.fromRGBO(237, 243, 250, 5.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(bottom: 40)),
            Align(
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
            Padding(padding: EdgeInsets.only(bottom: 80)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 80,
                    child: TextField(
                      controller: ID_Controller,
                      decoration: InputDecoration(
                        labelText: '아이디',
                        labelStyle: TextStyle(fontSize: 20),
                        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                        filled: true,
                        fillColor: fieldColor,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                          child: TextButton(
                            onPressed: () {
                              _checkd_id_uplication();
                            },
                            child: Text(
                              '중복 확인',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 80,
                child: TextField(
                  controller: Password_Controller,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(fontSize: 20),
                    contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    filled: true,
                    fillColor: fieldColor,
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                  obscureText: true,
                ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 80,
                child: TextField(
                  controller: Name_Controller,
                  decoration: InputDecoration(
                    labelText: '이름',
                    labelStyle: TextStyle(fontSize: 20),
                    contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    filled: true,
                    fillColor: fieldColor,
                    border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 80,
                  child: TextField(
                    controller: Nicname_Controller,
                    decoration: InputDecoration(
                      labelText: '닉네임 (또는 기업명)',
                      labelStyle: TextStyle(fontSize: 20),
                      contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                      filled: true,
                      fillColor: fieldColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      suffixIcon: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.17,
                        child: TextButton(
                          onPressed: () {
                            _checkd_nic_uplication();
                          },
                          child: Text(
                            '중복 확인',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('기업회원'),
                Checkbox(
                  value: is_company,
                  onChanged: (bool? value) {
                    setState(() {
                      is_company = value!;
                    });
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 60)),

            Container(
              width:200,
              height:60,
              child:
              ElevatedButton(
                  onPressed: () {
                    if (ID_Controller.text.isEmpty ||
                        Name_Controller.text.isEmpty ||
                        Password_Controller.text.isEmpty ||
                        Nicname_Controller.text.isEmpty) {
                      _showDialog(context);
                      return;
                    } else if (!id_check || !nic_check) {
                      _check_available_id_Dialog(context);
                      return;
                    }
                    user.set_ID(ID_Controller.text);
                    user.set_Name(Name_Controller.text);
                    user.set_PassWord(Password_Controller.text);
                    user.set_Nic(Nicname_Controller.text);
                    user.set_Type(is_company);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Hobby();
                    }));
                  }, // Next로 넘어가기전 필드에 적어놓은 정보 User에 저장
                  child: Text(
                    '다음',
                    style: TextStyle(fontSize: 18),
                ),
            ),
            ),
          ],
        ),
      ),
    ));
  }
}
