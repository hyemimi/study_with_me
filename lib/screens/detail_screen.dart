import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import '../models/study.dart';

class DetailScreen extends StatelessWidget {
  final StudyModel study;

  DetailScreen({required this.study});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(study: study),
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
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/logoImage.png',
                    image:
                        'http://10.0.2.2:3000/resources/banner/${study.banner}',
                    width: 360,
                    height: 300,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Image.asset('assets/logoImage.png');
                    }),
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
                  '예정된 스터디 일정',
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
              child: Column(children: [
                Text(
                  // 스터디 일정 및 장소
                  '장소 : ${study.location} \n진행시간 : ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(study.time).toLocal())} ~ ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(study.time).add(Duration(minutes: study.during)).toLocal())} \n (${(study.during / 60).floor()}시간) ',
                  style: TextStyle(fontSize: 15),
                ),
              ]),
            ),
          ]),
        )));
  }
}

//
