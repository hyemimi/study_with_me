import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_with_me/components/home_banner.dart';
import 'package:study_with_me/components/home_header.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import 'package:study_with_me/tabs/tabs.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Study With Me',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.primary))),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //HomeBanner(),
          //SizedBox(height: 5),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tabs(selectedIndex: 2)),
                    ),
                child: Text("스터디 생성"))
          ]),
          Expanded(
              child: (GridView.builder(
            shrinkWrap: true,
            itemCount: 30,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1,
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [Text('알고리즘 스터디')],
                ),
              );
            },
          )))
        ]));
  }
}
