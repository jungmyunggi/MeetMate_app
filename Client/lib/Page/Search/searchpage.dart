import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Global/global.dart';
import '../Util/viewtextpage.dart';

class Search extends StatefulWidget {
  final String h;
  const Search({required this.h});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<Map<String, dynamic>>> searchList;

  void initState() {
    super.initState();
    searchList = getPost();
  }

  Future<List<Map<String, dynamic>>> getPost() async {
    try {
      Response response = await dio.post("$baseUrl/article/list");

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> allData =
            List<Map<String, dynamic>>.from(response.data);
        print(allData);
        List<Map<String, dynamic>> filteredData = [];
        for (var data in allData) {
          if (data['category'].toString().compareTo(widget.h) == 0) {
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(widget.h)),
      body: FutureBuilder(
        future: searchList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> dataList = snapshot.data as List<Map<String, dynamic>>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(navigatorContext).size.width,
                    height: MediaQuery.of(navigatorContext).size.height * 0.72,
                    child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final post = dataList[index];
                        print(post);
                        return ListTile(
                          contentPadding: EdgeInsets.only(left: 20, bottom: 20),
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
                                      Text(
                                          post['upload_time'].substring(0, 10)),
                                    ],
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 20)),
                                  Text(
                                      post['content'].substring(0, 10) + '...'),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
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
            );
          }
        },
      ),
    ));
  }
}
