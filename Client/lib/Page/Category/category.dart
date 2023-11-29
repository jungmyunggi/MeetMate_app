import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../AppBar/appbar.dart';
import '../../AppBar/bottomappbar.dart';
import '../../Global/global.dart';
import '../Util/viewtextpage.dart';


class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late Future<List<Map<String, dynamic>>> categoryList;

  void initState() {
    super.initState();
    categoryList = getPost();
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
          if (user.User_Hobby.contains(data['category'])) {
            print(data['category']);
            filteredData.add(data);
          }
        }

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
          future: categoryList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('에러: ${snapshot.error}'));
            } else {
              List<Map<String, dynamic>> dataList =
                  snapshot.data as List<Map<String, dynamic>>;
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
                             print(dataList.toString());
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
