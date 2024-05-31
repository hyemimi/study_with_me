import 'package:flutter/material.dart';
import 'package:study_with_me/components/home_appbar.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

class CalenderScreen extends StatefulWidget {
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: '캘린더 페이지'),
        body: Center(child: Text('calender 화면')));
  }
}
