import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import '../models/study.dart';

class DetailScreen extends StatelessWidget {
  final StudyModel study;

  DetailScreen({required this.study});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text('${study.title}'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.tertiary),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Container(
              child: Center(
                child: Image.network(
                  'http://10.0.2.2:3000/resources/profileImage/user.png',
                  width: 360,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  //소개글
                  '스터디 소개',
                  style: TextStyle(fontSize: 15, color: Color(0xff939191)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: Color(0xffF7ECB4).withOpacity(0.24)),
              child: Text(
                // 상세정보
                '${study.description}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  //소개글
                  '스터디 일정',
                  style: TextStyle(fontSize: 15, color: Color(0xff939191)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: Color(0xffF7ECB4).withOpacity(0.24)),
              child: Text(
                // 스터디 일정 및 장소
                '',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ]),
        )));
  }
}
