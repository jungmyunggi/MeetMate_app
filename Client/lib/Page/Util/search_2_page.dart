import 'package:app_1/Global/hobbylist.dart';
import 'package:flutter/material.dart';

class Search_2 extends StatefulWidget {
  final int index;
  const Search_2({required this.index});

  @override
  State<Search_2> createState() => _Search_2State();
}

class _Search_2State extends State<Search_2> {
  final _search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
      appBar: AppBar(title: Text(Hobbys[widget.index])),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 20)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: detail_hobbys[widget.index].length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(child: Text(detail_hobbys[widget.index][index])),
                  ),
                );
              },
            ),
          ),

        ],
      ),

    )
    );
  }
}
