import 'package:flutter/material.dart';

import '../../Global/global.dart';

class Adminpage extends StatefulWidget {
  final List<dynamic> unick;
  Adminpage({required this.unick});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  _withdrawal_dialog(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('성공'),
            content: Text('완료'),
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
  _member_Withdrawal(String uid){
    final options = {
      "uid":uid,
    };
    print(options);
    dio.post('$baseUrl/member/delete',data: options).then((result){
      if(result.data){
          _withdrawal_dialog(context);
      }
      else {print(user.User_ID);}

    } );
  }
  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("관리자 전용"),
          actions: [
            ElevatedButton(onPressed: (){
              setState(() {

              });
              print(widget.unick);}, child: Text('새로고침'))
          ],
        ),
        body:
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                      for (var post in a)
                        ListTile( // 전체 사용자의 닉네임을 화면에 출력
                          title: Container(
                            child: Container(
                              decoration: BoxDecoration(border: Border(
                                  bottom: BorderSide(color: Colors.black))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(post),
                                  PopupMenuButton(
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text('사용자 삭제'),
                                          onTap: () {
                                            setState(() {
                                              a.remove(post);
                                            });
                                            _member_Withdrawal(post);
                                          },
                                        ),
                                      ];
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
