import 'package:app_1/Login/registlocal.dart';
import 'package:flutter/material.dart';

import '../Global/global.dart';
import '../Global/hobbylist.dart';
class Hobby extends StatefulWidget {
  const Hobby({super.key});

  @override
  State<Hobby> createState() => _HobbyState();
}

class _HobbyState extends State<Hobby> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int current_index = 0;
  String pick_hobby = '';
  int index = 0;
  int max_select = 3;
  List<bool> selectedHobbies = List.generate(Hobbys.length, (index) => false);
  //==> 전부 화면에 취미 리스트 띄우는데 필요한 변수

  void add_hobby(String h) {
    setState(() {
      if(user.User_type){
        setState(() {
          max_select = 1;
        });
      }
      if (pick_hobby.contains(h)) {
        pick_hobby = pick_hobby.replaceAll(h, '');
        index--;
      } else {
        if (index == max_select) {
          return;
        }
        pick_hobby += h;
        index++;
      }
      print(index);
    });
  } // 리스트내부에 같은 취미가 없을때 추가, 있으면 삭제

  @override
  void initState() {
    super.initState();
    myHobby.clear();
    _tabController = TabController(length: Hobbys.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text('취미선택'),
              Padding(padding: EdgeInsets.only(right: 20)),
              Text(
                pick_hobby,
                style: TextStyle(fontSize: 10, color: Colors.grey),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Local()), //Next버튼 클릭시 Local로 넘어감
                );
              },
              child: Text('Next'),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Scrollbar(
                      child: ListView.builder( // hobbylist에 있는 상위 취미 리스트 띄우기
                        itemCount: Hobbys.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                current_index = index;
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(child: Text(Hobbys[index])),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder( // 하위리스트 띄우기
                      itemCount: detail_hobbys[current_index].length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              add_hobby(
                                  detail_hobbys[current_index][index] + ' ');
                              user.set_Hobby(pick_hobby);
                            });
                          },
                          child: Container(
                            height:
                            MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromARGB(
                                  100, 96, 96, 96)),
                              color: pick_hobby.contains(detail_hobbys[current_index][index])
                                  ? Color.fromRGBO(255, 242, 126, 1.0) // 선택시 색을 노란색으로 바꿈
                                  : null,
                            ),
                            child: Center(
                                child: Text(
                                    detail_hobbys[current_index][index])),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
