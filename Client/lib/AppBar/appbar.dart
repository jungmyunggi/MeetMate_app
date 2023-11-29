import 'dart:io';
import 'package:app_1/Page/Admin/adminpage.dart';
import 'package:app_1/Global/global.dart';
import 'package:app_1/Page/Util/invitationpage.dart';
import 'package:flutter/material.dart';
import '../Page/Search/Search_1_page.dart';

//상단 AppBar
final AppBar TopAppbar = AppBar(
  toolbarHeight: 70,
  title: Text(
    user.User_Local,
    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
  ),// 상단에 사용자가 지정한 위치가 나온다
  actions: [
    Row(
      children: [
        ElevatedButton(
            onPressed: () {
              if (user.User_Nic.compareTo("admin") == 0) {
                  dio.get('$baseUrl/member/admin').then((value) {
                    a = value.data;
                    print(a);
                    Navigator.push(navigatorContext, MaterialPageRoute(
                      builder: (context) {
                        return Adminpage(unick: a,); // 사용자 닉네임이 admin이면 Adminpage로 이동
                      },
                    ));
                  } );

              } else {
                showDialog(
                    context: navigatorContext,
                    barrierDismissible: false,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('경고'),
                        content: const Text('관리자만 사용가능합니다'),
                        actions: [
                          TextButton(
                            onPressed: () {

                              Navigator.of(ctx).pop();
                            },
                            child: const Text('확인'),
                          ),
                        ],
                      );
                    });// 오류창 발생
              }
            },
            child: Text('사용자 관리')),
        IconButton(
            style: IconButton.styleFrom(iconSize: 30),
            onPressed: () {
              Navigator.push(navigatorContext, MaterialPageRoute(
                builder: (context) {
                  return Search_1();
                },
              ));
            }, // 검색 버튼
            icon: Icon(Icons.search)),
        IconButton(
            style: IconButton.styleFrom(iconSize: 30),
            onPressed: () async {
              final options = {
                'sender' : user.User_Nic
              };

              dio.post('$baseUrl/invitation/send',data: options).then((value){
                print(value);
                invit = value.data;

              });
              await Future.delayed(Duration(milliseconds: 500),()=>
                  Navigator.push(navigatorContext, MaterialPageRoute(
                    builder: (context) {
                      return Invitation();
                    },
                  ))
              );

            }, // 초대장 버튼
            icon: Icon(Icons.mail)),
      ],
    )
  ],
  automaticallyImplyLeading: false,
);
