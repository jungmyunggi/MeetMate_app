import 'package:app_1/Page/Search/search_2_page.dart';
import 'package:app_1/Global/hobbylist.dart';
import 'package:flutter/material.dart';

class Search_1 extends StatefulWidget {
  const Search_1({Key? key}) : super(key: key);

  @override
  State<Search_1> createState() => _Search_1State();
}

class _Search_1State extends State<Search_1> {
  final _search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('취미검색')),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 20)),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: Hobbys.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search_2(index: index),
                          ),
                        );
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(child: Text(Hobbys[index])),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
