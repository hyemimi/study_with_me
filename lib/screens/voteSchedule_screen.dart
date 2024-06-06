import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/detail_screen.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:http/http.dart' as http;
import '../models/schedule.dart';

class voteScheduleScreen extends StatefulWidget {
  @override
  State<voteScheduleScreen> createState() => _voteScheduleScreenState();
  StudyModel study;
  voteScheduleScreen({required this.study});
}

class _voteScheduleScreenState extends State<voteScheduleScreen> {
  late List<ScheduleModel> schedule = [];
  late List<int> checkedSchedule = [];
  var user_id = Provider.of<UserProvider>(
          CandyGlobalVariable.naviagatorState.currentState!.context)
      .user_id;

  void waitSchedule() async {
    schedule = await ApiService().getSchedule(widget.study.invite_code);
    print(schedule);
    setState(() {});
  }

  void postSchedule() async {
    dynamic body = {
      "user_id": user_id,
      "checkedSchedule": checkedSchedule,
    };
    body = jsonEncode(body);

    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/calendar/voteSchedule'),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 401) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(
                title: Icon(Icons.warning),
                content: Text('투표가 이미 완료되었습니다'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(study: widget.study)))
                          .then((value) => setState(() {}));
                    },
                    child: Text('확인'),
                  ),
                ]);
          });
    }

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(
                title: Text('투표 완료'),
                content: Text('일정이 확정될 때까지 기다려주세요'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(study: widget.study)))
                          .then((value) => setState(() {}));
                    },
                    child: Text('확인'),
                  ),
                ]);
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('일정 투표')),
        body: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(children: [
              SizedBox(height: 10),
              Text("가능한 모든 날짜를 선택해주세요"),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: schedule.length,
                  itemBuilder: (context, index) {
                    var it = schedule![index];
                    return schedule.length > 0
                        ? GestureDetector(
                            onTap: () => {},
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Checkbox(
                                      value: checkedSchedule
                                          .contains(it.schedule_id),
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == true) {
                                            checkedSchedule.add(it.schedule_id);
                                          } else {
                                            checkedSchedule
                                                .remove(it.schedule_id);
                                          }
                                          print(checkedSchedule);
                                        });
                                      }),
                                  SizedBox(
                                      width: 160,
                                      child: Text(
                                          '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(it.time).add(Duration(hours: 9)))}\n~${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(it.time).add(Duration(hours: 9, minutes: it.during)))}',
                                          style: TextStyle(fontSize: 18),
                                          textAlign: TextAlign.start)),
                                  //SizedBox(width: 150),
                                  SizedBox(width: 10),
                                  Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        it.location,
                                        textAlign: TextAlign.center,
                                      )),
                                ]))
                        : Text("게시물이 없습니다");
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xffDFDFDF),
                    height: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
              ),
              ElevatedButton(onPressed: () => postSchedule(), child: Text("등록"))
            ])));
  }
}
