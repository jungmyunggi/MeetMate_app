import 'package:app_1/Login/registlocal.dart';
import 'package:app_1/Global/global.dart';
import 'package:flutter/material.dart';
import 'package:app_1/Global/hobbylist.dart';
class Pick extends StatefulWidget {
  const Pick({super.key});

  @override
  State<Pick> createState() => _PickState();
}

class _PickState extends State<Pick> with SingleTickerProviderStateMixin {
  late TabController _tabController;


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
  int current_index =0;
  String pick_hobby = '';
  int index =0;
  int max_select = 3;
  void add_hobby(String h) {
    if(user.User_type){
      setState(() {
        max_select = 1;
      });
    }
    setState(() {
      if (pick_hobby.contains(h)) {
        pick_hobby = pick_hobby.replaceAll(h, '');
        index--;
      } else {
        if(index == max_select){
          return;
        }
        pick_hobby += h;
        index++;
      }
      print(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text('취미선택'),actions: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Local(),));

              }, child: Text('Next'))
            ],),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height*0.8,
                        child: Scrollbar(
                          child: ListView.builder(
                            itemCount: Hobbys.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current_index = index;
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height*0.1,
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
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.8,
                        child:
                      ListView.builder(
                        itemCount: detail_hobbys[current_index].length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                add_hobby(detail_hobbys[current_index][index]+' ');
                                user.set_Hobby(pick_hobby);
                              });
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.1,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(child: Text(detail_hobbys[current_index][index])),
                            ),
                          );
                        },
                      ),
                      ),
                    ],
                  ),
                  Text("선택한 취미: "+pick_hobby),
                ],
              ),
            ),
        ));
  }
}
