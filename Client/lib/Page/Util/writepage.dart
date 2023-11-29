import 'package:app_1/Global/koreanlocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Global/global.dart';
import '../../Global/hobbylist.dart';
import '../Home/homepage.dart';

class Write extends StatefulWidget {
  const Write({super.key});

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  final content_controller = TextEditingController();
  final title_controller = TextEditingController();
  final chat_controller = TextEditingController();
  final time_controller = TextEditingController();
  String _resultMessage = '';
  String selectedCategory = '운동';
  String selectedSubCategory = '축구';
  String selectedLocal = '서울';
  String selectedLocal_detail = '강남구';

  _successDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('성공'),
            content: Text('글을 저장하였습니다'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Home();
                  }));
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  }
  _failDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text("실패"),
            content: Text("모든 내용을 채워주세요/내용 필드는 10자 이상으로 작성해주세요"),
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

  final detailHobbys = {
    '운동': detail_hobbys[0],
    '아웃도어/여행': detail_hobbys[1],
    '언어': detail_hobbys[2],
    '봉사활동': detail_hobbys[3],
    '댄스/무용': detail_hobbys[4],
    '문화/공연': detail_hobbys[5],
    '기타':detail_hobbys[6],
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

  void write() {
    if (title_controller.text.isEmpty ||
        content_controller.text.length<10 ||
        chat_controller.text.isEmpty) {
      _failDialog(context);
      return;
    }
    final options = {
      "title": title_controller.text,
      "nickname": user.User_Nic,
      "category": selectedSubCategory,
      "location": selectedLocal_detail,
      "content": content_controller.text,
      "chat": chat_controller.text,
      "meetTime" : time_controller.text,
    };
    print(options);
    dio
        .post("$baseUrl/article/write", data: options)
        .then((result) async => {
              print(result),
              if (result.data)
                {
                  _successDialog(context)
                }
              else
                {
                  _failDialog(context)
                }
            })
        .catchError((error) => {
              print(error),
              print("에러"),
            });
  }

  @override
  Widget build(BuildContext context) {
    List<String> subCategories = getSubCategories(selectedCategory);
    List<String> detail_locals = getdetail_Local(selectedLocal);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('글쓰기'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 50,
                      child: TextField(
                        controller: title_controller,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: '제목'),
                      ),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('카테고리  '),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.33,
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                    subCategories =
                                        getSubCategories(selectedCategory);
                                    selectedSubCategory = subCategories.isNotEmpty
                                        ? subCategories[0]
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
                              value: selectedSubCategory,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSubCategory = newValue!;
                                });
                              },
                              items: subCategories.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ]),
                    ),
                    Container(
                      decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 70,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('지역설정  '),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.33,
                              child: DropdownButton<String>(
                                value: selectedLocal,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedLocal = newValue!;
                                    selectedLocal_detail = detail_Local[selectedLocal]![0];
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
                            SizedBox(height: 20.0),
                            DropdownButton<String>(
                              value: selectedLocal_detail,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLocal_detail = newValue!;
                                });
                              },
                              items: detail_locals.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ]),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TextField(
                          controller: content_controller,
                          expands: true,
                          maxLines: null,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: '내용'),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 50,
                        child: TextField(
                          controller: time_controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                            MyInputFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '일정 (yy년 mm월 dd일 hh시 mm분)',
                          ),
                        ),),

                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 50,
                        child: TextField(
                          controller: chat_controller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '오픈채팅 주소'),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          write();
                       //   Navigator.pop(context);
                        },
                        child: Text('글쓰기'))
                  ]),
            ),
          )),
    );
  }
  void _validateInput() {
    String inputText = time_controller.text;

    if (RegExp(r'^\d{2}년\d{2}월\d{2}일\d{2}시\d{2}분$').hasMatch(inputText)) {
      setState(() {
        _resultMessage = '$inputText';
      });
    } else {
      setState(() {
        _resultMessage = '';
      });
    }
  }
}

class MyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 10) {
      final String formattedText =
          '${newValue.text.substring(0, 2)}년${newValue.text.substring(2, 4)}월${newValue.text.substring(4,6)}일${newValue.text.substring(6,8)}시${newValue.text.substring(8,10)}분';
      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return newValue;
  }
}
