import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/components/home_appbar.dart';
import 'package:study_with_me/models/alarm.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/home_screen.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:study_with_me/models/coins.dart';
import 'package:http/http.dart' as http;

class AlarmScreen extends StatefulWidget {
  AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late List<AlarmModel> alarms = [];
  var user_id = Provider.of<UserProvider>(
          CandyGlobalVariable.naviagatorState.currentState!.context)
      .user_id;

  void waitForAlarm() async {
    alarms = await ApiService().getNotification(user_id);
    setState(() {});
  }

  void joinStudy(String invite_code, int notify_id) async {
    dynamic body = {
      "invite_code": invite_code,
      "user_id": user_id.toString(),
      "notify_id": notify_id.toString(),
    };
    body = jsonEncode(body);

    // 스터디 가입
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/study/addStudyUser'),
        headers: {"Content-Type": "application/json"},
        body: body);
    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(content: Text('스터디 참여 완료'), actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeScreen()))
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
    super.initState();
    waitForAlarm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('알람'))),
        body: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                var alarm = alarms![index];
                return alarms.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 200, child: Text('${alarm!.content}')),
                          TextButton(
                              onPressed: () =>
                                  joinStudy(alarm.invite_code, alarm.notify_id),
                              child: Text('참가하기'))
                        ],
                      )
                    : Center(child: Text('알람이 존재하지 않습니다'));
              },
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xffDFDFDF),
                height: 0,
                indent: 16,
                endIndent: 1,
              ),
            ),
          ),
        ));
  }
}
