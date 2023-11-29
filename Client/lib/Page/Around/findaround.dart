import 'package:app_1/Page/Around/findaround.dart';
import 'package:app_1/Page/Home/homepage.dart';
import 'package:app_1/Page/Info/myinfopage.dart';
import 'package:app_1/AppBar/appbar.dart';
import 'package:app_1/Global/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_1/AppBar/bottomappbar.dart';

import '../Util/viewtextpage.dart';

class Around extends StatefulWidget {
  const Around({super.key});

  @override
  State<Around> createState() => _AroundState();
}

class _AroundState extends State<Around> {
  late Future<List<Map<String, dynamic>>> locationList;

  void initState() {
    super.initState();
    locationList = getPost();
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    try {
      Response response = await dio.post("$baseUrl/article/list");

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> allData =
        List<Map<String, dynamic>>.from(response.data);
        List<Map<String, dynamic>> filteredData = [];
        print(user.User_Hobby);
        for (var data in allData) {
          if (user.User_Local.contains(data['location'])) {
            filteredData.add(data);
          }
        }
          // user가 저장한 위치와 동일한 위치에 대한 글 필터링
        return filteredData;
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
            appBar: TopAppbar,
            body: FutureBuilder(
              future: locationList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('에러: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> dataList =
                  snapshot.data as List<Map<String, dynamic>>;
                  print(dataList);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(navigatorContext).size.width,
                          height:
                          MediaQuery.of(navigatorContext).size.height * 0.72,
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
                                            padding: EdgeInsets.only(right: 20)),
                                        Text(post['content'].substring(0, 10) +
                                            '...'),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Viewtext(index: index,dataList: dataList),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            bottomNavigationBar: BtmAppBar,
          )),
    );
  }
}
