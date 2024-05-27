import 'package:flutter/material.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

class ScheduleScreen extends StatefulWidget {
  StudyModel study;
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();

  ScheduleScreen({required this.study});
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
        body: Center(child: Text('(스터디원) 일정 등록 화면')));
  }
}
