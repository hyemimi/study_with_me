import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/screens/detail_screen.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:http/http.dart' as http;

class AdminScheduleScreen extends StatefulWidget {
  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();

  StudyModel study;
  AdminScheduleScreen({super.key, required this.study});
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
  late int hour, minutes;
  int during = 0;
  String location = '';

  // time 배열로 넘겨야 함 TimeModel 만들기

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final format = DateFormat("yyyy-MM-dd HH:mm");
  List<DateTime?> selectedDateTimes = [];

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      if (time != null) {
        setState(() {
          selectedDateTimes.add(DateTimeField.combine(date, time));
        });
      }
    }
  }

  void submitTimes() async {
    var selectedDateTimesString = [];

    selectedDateTimes.forEach((element) {
      selectedDateTimesString.add(element?.toIso8601String());
    });

    dynamic body = {
      "invite_code": widget.study.invite_code,
      "during": during.toString(),
      "location": location,
      "selectedDateTimes": selectedDateTimesString
    };
    body = jsonEncode(body);

    // 스터디 생성
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/study/registerSchedule'),
        headers: {"Content-Type": "application/json"},
        body: body);
    if (response.statusCode == 200) {
      // 서버에 이미지 업로드
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(content: Text('일정이 등록되었습니다'), actions: [
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
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(study: widget.study),
        appBar: AppBar(
          title: Text('스터디 일정 등록'),
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Text(
                      //소개글
                      '위치',
                      style: TextStyle(fontSize: 18, color: Color(0xff939191)),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        location = value;
                        setState(() {});
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'ex) 중앙도서관',
                        filled: true,
                        fillColor: Color(0xffF7ECB4).withOpacity(0.24),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      //소개글
                      '진행시간',
                      style: TextStyle(fontSize: 18, color: Color(0xff939191)),
                    ),
                  ),
                  Container(
                    width: 70,
                    child: TextFormField(
                      onChanged: (value) {
                        hour = int.parse(value);
                        during += hour * 60;
                        setState(() {});
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF7ECB4).withOpacity(0.24),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                      //소개글
                      '시간',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff939191),
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Container(
                    width: 70,
                    child: TextFormField(
                      onChanged: (value) {
                        minutes = int.parse(value);
                        during += minutes;
                        setState(() {});
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF7ECB4).withOpacity(0.24),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    //소개글
                    '분',
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff939191),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                child: Text(
                  //소개글
                  '날짜 / 시간 범위 설정',
                  style: TextStyle(fontSize: 18, color: Color(0xff939191)),
                ),
              ),
              if (during > 0)
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    child: Icon(Icons.add),
                    onPressed: () => _selectDateTime(context),
                  )
                ]),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedDateTimes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Center(
                        child: Text(
                          '${format.format(selectedDateTimes[index]!)} ~ ${format.format(selectedDateTimes[index]!.add(Duration(minutes: during)))} ',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ));
                  },
                ),
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: submitTimes, child: Text("등록하기")))
            ],
          ),
        ));
  }
}
