import 'package:app_1/Global/global.dart';
import 'package:app_1/Page/Util/moditypage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Home/homepage.dart';



class Viewtext extends StatefulWidget {
  final int index;
  List<Map<String, dynamic>> dataList;
  Viewtext({required this.index,required this.dataList});

  @override
  _ViewtextState createState() => _ViewtextState();
}

class _ViewtextState extends State<Viewtext> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final comment_modify_controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> futureData ;
  String comment_text_title = '';
  String comment_text_content = '';
  int i = 0;


  _comment_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(comment_text_title),
            content: Text(comment_text_content),
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

  String invitation_text_title = '';
  String invitation_text_content = '';

  _invitation_Dialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(invitation_text_title),
            content: Text(invitation_text_content),
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

  _delete_article(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('성공'),
            content: const Text('게시글을 삭제했습니다'),
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

  _modify_comment(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: TextField(
              controller: comment_modify_controller,
              decoration: InputDecoration(labelText: "수정할 댓글"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (comment_modify_controller.text.length <= 20) {
                    final options = {
                      "id": reviewList[i]["commentId"],
                      "content": comment_modify_controller.text,
                    };
                    print(options);
                    dio.post("$baseUrl/comment/edit", data: options).then(
                      (result) {
                        setState(() {
                          Navigator.of(ctx).pop();
                          futureData = fetchData();
                        });
                      },
                    ).catchError((error) {
                      print(error);
                    });
                  } else {
                    comment_text_title = '실패';
                    comment_text_content = '댓글 수정에 실패했습니다';
                    _comment_Dialog(context);
                  }
                },
                child: const Text('확인'),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    futureData = fetchData();
  }

  final commentController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  Future<List<Map<String, dynamic>>> fetchData() async {
    final options = {
      "articleId": widget.dataList[widget.index]['id'],
    };
    print(options);
    try {
      Response result = await dio.post("$baseUrl/comment/list", data: options);
      late List<Map<String, dynamic>> data;
      setState(() {
         data =
        List<Map<String, dynamic>>.from(result.data);
      });
      return data;
    } catch (error) {
      throw Exception('데이터를 불러오는 데 실패했습니다.');
    }
  }

  void Delete_post() {
    final options = {
      "id": widget.dataList[widget.index]['id'],
    };
    print(options);
    dio.post("$baseUrl/article/delete", data: options).then(
      (result) {
        setState(() {
          _delete_article(context);
        });
      },
    ).catchError((error) {
      print(error);
    });
  }

  void postcomment() {
    final options = {
      "articleId": widget.dataList[widget.index]["id"],
      "nickname": user.User_Nic,
      "content": commentController.text,
    };
    dio.post("$baseUrl/comment/write", data: options).then(
      (result) {
        setState(() {
          futureData = fetchData();
          _comment_Dialog(context);
          commentController.clear();
        });
      },
    ).catchError((error) {
      print(error);
    });
  }

  void _showPopupMenu(BuildContext context, int index) async {
    final selectedValue = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(500.0, 500.0, 0.0, 0.0),
      items: [
        PopupMenuItem(
          child: Text('프로필보기'),
          onTap: () {
            print('object');
          },
        ),
        PopupMenuItem(
            child: Text('초대장 보내기'),
            onTap: () {
              print(widget.dataList[widget.index]['nickname'].toString());
              print(user.User_Nic);
              if (widget.dataList[widget.index]['nickname']
                      .toString()
                      .compareTo(user.User_Nic) ==
                  0) {
                final options = {
                  'articleId': widget.dataList[widget.index]['id'],
                  'sender': user.User_Nic,
                  'receiver': reviewList[index]['nickname'],
                };
                dio
                    .post('$baseUrl/invitation/invite', data: options)
                    .then((value) {
                  if (value.data) {
                    setState(() {
                      invitation_text_content = '초대장을 보냈습니다';
                      invitation_text_title = '성공';
                      _invitation_Dialog(context);
                    });
                  } else {
                    invitation_text_content = '초대장을 보내지 못했습니다';
                    invitation_text_title = '실패';
                    _invitation_Dialog(context);
                  }
                });
              } else {
                comment_text_title = '실패';
                comment_text_content = '권한이 없습니다';
                _comment_Dialog(context);
              }
            }),
      ],
      elevation: 8.0,
    );

    // Handle the selected value
    if (selectedValue != null) {
      print('Selected: $selectedValue');
      // You can perform additional actions based on the selected value
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text('로딩 중')),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text('에러')),
            body: Center(child: Text('에러')),
          );
        } else {
          reviewList = snapshot.data as List<Map<String, dynamic>>;
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(title: Text(widget.dataList[widget.index]['title'])),
            body: SizedBox(
              height: MediaQuery.of(context).size.height * 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dataList[widget.index]['nickname'],
                            style: TextStyle(fontSize: 30),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 20)),
                          Text(
                           widget.dataList[widget.index]['content'],
                            style: TextStyle(fontSize: 25),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.dataList[widget.index]['location'],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  Text(widget.dataList[widget.index]['meetTime'],
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10)),
                                  Expanded(child: SizedBox()),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (widget.dataList[widget.index]['nickname']
                                                  .toString()
                                                  .compareTo(user.User_Nic) ==
                                              0 ||
                                          user.User_Nic.compareTo("admin") ==
                                              0) {
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Modify(index: widget.index,dataList: widget.dataList),
                                            ),
                                          );
                                        });
                                      }
                                    },
                                    child: Text('수정'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (widget.dataList[widget.index]['nickname']
                                                  .toString()
                                                  .compareTo(user.User_Nic) ==
                                              0 ||
                                          user.User_Nic.compareTo("admin") ==
                                              0) {
                                        Delete_post();
                                      }
                                    },
                                    child: Text('삭제'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 5,
                          ),
                        ),
                      ),
                    ),

                    //댓글 보기
                    Column(
                      children: List.generate(
                        reviewList.length,
                        (index) => ListTile(
                          title: Align(
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          _showPopupMenu(context, index);
                                        },
                                        child: Text(
                                            '${reviewList[index]['nickname']}')),
                                    Text(
                                      ': '
                                      '${reviewList[index]['content']}',
                                    ),
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text('수정'),
                                        onTap: () {
                                          i = index;
                                          if (reviewList[index]['nickname']
                                                  .toString()
                                                  .contains(user.User_Nic) ||
                                              user.User_Nic.compareTo(
                                                      "admin") ==
                                                  0) {
                                            setState(() {
                                              _modify_comment(context);
                                            });
                                          } else {
                                            setState(() {
                                              comment_text_title = '실패';
                                              comment_text_content =
                                                  '권한이 없습니다';
                                              _comment_Dialog(context);
                                            });
                                          }
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text('삭제'),
                                        onTap: () {
                                          if (reviewList[index]['nickname']
                                                  .toString()
                                                  .contains(user.User_Nic) ||
                                              user.User_Nic.compareTo(
                                                      "admin") ==
                                                  0) {
                                            setState(() {
                                              comment_text_title = '성공';
                                              comment_text_content =
                                                  '댓글을 삭제했습니다';
                                              final options = {
                                                "id": reviewList[index]
                                                    ["commentId"],
                                              };
                                              print(options);
                                              dio
                                                  .post(
                                                      "$baseUrl/comment/delete",
                                                      data: options)
                                                  .then(
                                                (result) {
                                                  setState(() {
                                                    futureData = fetchData();
                                                    _comment_Dialog(context);
                                                    commentController.clear();
                                                  });
                                                },
                                              ).catchError((error) {
                                                print(error);
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              comment_text_title = '실패';
                                              comment_text_content =
                                                  '권한이 없습니다';
                                              _comment_Dialog(context);
                                            });
                                          }
                                        },
                                      )
                                    ];
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //댓글 작성
            bottomNavigationBar: BottomAppBar(
              height: MediaQuery.of(context).viewInsets.bottom + 60,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 50,
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: "댓글을 입력하세요...(20자 이내)"),
                      controller: commentController,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (commentController.text.length <= 20) {
                              comment_text_content = '댓글을 작성했습니다';
                              comment_text_title = '성공';
                              postcomment();
                            } else {
                              comment_text_content = '댓글 작성에 실패했습니다';
                              comment_text_title = '오류';
                              _comment_Dialog(context);
                            }
                          });
                        },
                        icon: Icon(Icons.send),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
