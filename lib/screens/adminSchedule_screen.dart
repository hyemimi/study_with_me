import 'package:flutter/material.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

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
            ],
          ),
        ));
  }
}
