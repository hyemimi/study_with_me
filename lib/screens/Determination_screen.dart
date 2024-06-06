import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/models/user.dart';
import 'package:study_with_me/screens/detail_screen.dart';
import 'package:study_with_me/screens/home_screen.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import 'package:http/http.dart' as http;
import 'package:study_with_me/tabs/home_tabs/tabs.dart';

class DeterminationScreen extends StatefulWidget {
  StudyModel study;
  @override
  State<DeterminationScreen> createState() => _DeterminationScreenState();

  DeterminationScreen({required this.study});
}

class _DeterminationScreenState extends State<DeterminationScreen> {
  late int completedMembers = 0;

  void waitCompletedMembers() async {
    completedMembers =
        await ApiService().getCompletedMembers(widget.study.invite_code);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitCompletedMembers();
  }

  void terminateVote() async {
    dynamic body = {"invite_code": widget.study.invite_code};
    body = jsonEncode(body);

    // 스터디 생성
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/calendar/terminateVote'),
        headers: {"Content-Type": "application/json"},
        body: body);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(
                title: Text('성공'),
                content: Text('투표가 마감되었습니다'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Tabs(selectedIndex: 0)))
                            .then((value) => setState(() {}));
                      },
                      child: Text('확인'))
                ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(study: widget.study),
        appBar: AppBar(
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              completedMembers > 0 ? '${completedMembers}명 투표 완료' : '',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: terminateVote, child: Text("투표 마감하기"))
          ],
        )));
  }
}
