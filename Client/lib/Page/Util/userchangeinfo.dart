import 'package:app_1/Global/global.dart';
import 'package:app_1/Page/Info/myinfopage.dart';
import 'package:flutter/material.dart';
import '../../Global/hobbylist.dart';
import '../../Global/koreanlocal.dart';

class User_mo extends StatefulWidget {
  const User_mo({super.key});

  @override
  State<User_mo> createState() => _User_moState();
}

class _User_moState extends State<User_mo> {
  _successDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("성공"),
            content: Text("회원정보를 성공적으로 수정하였습니다\n 업데이트 완료를 위해 앱을 종료했다 켜주세요"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Info();
                  }));
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  }
  String selectedCategory1 = '운동';
  String selectedSubCategory1 = '축구';
  String selectedLocal1 = '서울';
  String selectedLocal_detail1 = '강남구';

  String selectedCategory2 = '운동';
  String selectedSubCategory2 = '축구';
  String selectedLocal2 = '서울';
  String selectedLocal_detail2 = '강남구';

  String selectedCategory3 = '운동';
  String selectedSubCategory3 = '축구';
  String selectedLocal3 = '서울';
  String selectedLocal_detail3 = '강남구';

  final detailHobbys = {
    '운동': detail_hobbys[0],
    '아웃도어/여행': detail_hobbys[1],
    '언어': detail_hobbys[2],
    '봉사활동': detail_hobbys[3],
    '댄스/무용': detail_hobbys[4],
    '문화/공연': detail_hobbys[5],
    '여가': detail_hobbys[6],
    '기타': detail_hobbys[7],
  };
  final detail_Local = {
    '서울': detail_regions[0],
    '경기': detail_regions[1],
    '부산': detail_regions[2],
    '대구': detail_regions[3],
    '인천': detail_regions[4],
    '광주': detail_regions[5],
    '대전': detail_regions[6],
    '울산': detail_regions[7],
    '세종': detail_regions[8],
    '강원': detail_regions[9],
    '충북': detail_regions[10],
    '충남': detail_regions[11],
    '전북': detail_regions[12],
    '전남': detail_regions[13],
    '경북': detail_regions[14],
    '경남': detail_regions[15],
    '제주': detail_regions[16],
  };

  List<String> getSubCategories(String category) {
    return detailHobbys[category] ?? [];
  }

  List<String> getdetail_Local(String Local) {
    return detail_Local[Local] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<String> subCategories1 = getSubCategories(selectedCategory1);
    List<String> detail_locals1 = getdetail_Local(selectedLocal1);
    List<String> subCategories2 = getSubCategories(selectedCategory2);
    List<String> detail_locals2 = getdetail_Local(selectedLocal2);
    List<String> subCategories3 = getSubCategories(selectedCategory3);
    List<String> detail_locals3 = getdetail_Local(selectedLocal3);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('회원수정')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('사용자 ID:'),
                  Text(user.User_ID),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('사용자 닉네임 : ',),
                  Text(user.User_Nic),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Column(
                children: [
                  Text('취미선택',style: TextStyle(fontSize: 20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: DropdownButton<String>(
                          value: selectedCategory1,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory1 = newValue!;
                              subCategories1 = getSubCategories(selectedCategory1);
                              selectedSubCategory1 = subCategories1.isNotEmpty
                                  ? subCategories1[0]
                                  : ''; // 초기값 설정
                            });
                          },
                          items: Hobbys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButton<String>(
                        value: selectedSubCategory1,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubCategory1 = newValue!;
                          });
                        },
                        items: subCategories1.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: DropdownButton<String>(
                          value: selectedCategory3,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory3 = newValue!;
                              subCategories3 = getSubCategories(selectedCategory3);
                              selectedSubCategory3 = subCategories3.isNotEmpty
                                  ? subCategories3[0]
                                  : ''; // 초기값 설정
                            });
                          },
                          items: Hobbys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButton<String>(
                        value: selectedSubCategory3,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubCategory3 = newValue!;
                          });
                        },
                        items: subCategories3.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: DropdownButton<String>(
                          value: selectedCategory2,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCategory2 = newValue!;
                              subCategories2 = getSubCategories(selectedCategory2);
                              selectedSubCategory2 = subCategories2.isNotEmpty
                                  ? subCategories2[0]
                                  : ''; // 초기값 설정
                            });
                          },
                          items: Hobbys.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButton<String>(
                        value: selectedSubCategory2,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubCategory2 = newValue!;
                          });
                        },
                        items: subCategories2.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
                  Padding(padding: EdgeInsets.all(20)),
                  Text('위치선택',style: TextStyle(fontSize: 20),),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.33,
                          child: DropdownButton<String>(
                            value: selectedLocal1,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocal1 = newValue!;
                                selectedLocal_detail1 = detail_Local[selectedLocal1]![0];
                              });
                            },
                            items: detail_Local.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedLocal_detail1,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocal_detail1 = newValue!;
                            });
                          },
                          items: detail_locals1.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.33,
                          child: DropdownButton<String>(
                            value: selectedLocal2,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocal2 = newValue!;
                                selectedLocal_detail2 = detail_Local[selectedLocal2]![0];
                              });
                            },
                            items: detail_Local.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedLocal_detail2,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocal_detail2 = newValue!;
                            });
                          },
                          items: detail_locals2.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.33,
                          child: DropdownButton<String>(
                            value: selectedLocal3,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLocal3 = newValue!;
                                selectedLocal_detail3 = detail_Local[selectedLocal3]![0];
                              });
                            },
                            items: detail_Local.keys.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedLocal_detail3,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocal_detail3 = newValue!;
                            });
                          },
                          items: detail_locals3.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ]),
                  ElevatedButton(onPressed: (){
                    final options = {
                        "nickname" : user.User_Nic,
                        "local" : selectedLocal_detail1+" "+selectedLocal_detail2+" "+selectedLocal_detail3,
                        "hobby" : selectedSubCategory1+" "+selectedSubCategory2+" "+selectedSubCategory3,
                    };
                    dio.post("$baseUrl/member/update",data: options).then((value) => {
                      setState(() {
                        user.User_Local =   selectedLocal_detail1+" "+selectedLocal_detail2+" "+selectedLocal_detail3;
                        user.User_Hobby = selectedSubCategory1+" "+selectedSubCategory2+" "+selectedSubCategory3;
                        _successDialog(context);
                        })
                      });

                  }, child: Text('회원수정'))
            ]),
          ),
        ),
      ),
    );
  }
}
