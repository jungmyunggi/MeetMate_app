import 'package:app_1/AppBar/appbar.dart';
import 'package:app_1/Page/Util/writepage.dart';
import 'package:app_1/Global/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_1/AppBar/bottomappbar.dart';
import 'package:app_1/Page/Util/viewtextpage.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    futureDataList = getPost();
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    try {
      Response response = await dio.post("$baseUrl/article/list");
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        print('데이터 가져오기 실패');
        throw Exception('데이터 가져오기 실패');
      }
    } catch (e) {
      print('에러: $e');
      throw Exception('에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    initNavigatorContext(context);
    setNavigatorContext(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: TopAppbar,
          body: FutureBuilder(
            future: futureDataList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('에러: ${snapshot.error}'));
              } else {
                List<Map<String, dynamic>> dataList = snapshot.data as List<Map<String, dynamic>>;
                return SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            child: TextButton(
                              onPressed: () {
                                final options = {
                                  "nickname": user.User_Nic,
                                };
                                dio.post('$baseUrl/article/post',data: options).then((value) {
                                  if (value.data) {
                                    Navigator.of(navigatorContext).push(
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Write(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  }else{
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext ctx) {
                                          return AlertDialog(
                                            title: Text('실패'),
                                            content: Text('하루에 3or1개만 가능합니다'),
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
                                });
                              },
                              child: Text(
                                '글쓰기',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            alignment: Alignment.centerRight,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(navigatorContext).size.width,
                          height:
                              MediaQuery.of(navigatorContext).size.height *
                                  0.72,
                          child: ListView.builder(
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              final post = dataList[index];
                              return ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 20, bottom: 20),
                                title: Align(
                                  child: Text(
                                    post['title'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  alignment: Alignment.center,
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(post['nickname']),
                                            Text(post['upload_time']
                                                .substring(0, 10)),
                                          ],
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 20)),
                                        Text(
                                            post['content'].substring(0, 10) +
                                                '...'),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  print(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Viewtext(index: index,dataList: dataList),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: BtmAppBar,
        ),
      ),
    );
  }
}
