import 'package:flutter/material.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

class AdminScheduleScreen extends StatefulWidget {
  StudyModel study;

  AdminScheduleScreen({required this.study});
  @override
  State<AdminScheduleScreen> createState() => _AdminScheduleScreenState();
}

class _AdminScheduleScreenState extends State<AdminScheduleScreen> {
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
        body: Center(child: Text('스터디장 일정 등록 화면')));
  }
}
