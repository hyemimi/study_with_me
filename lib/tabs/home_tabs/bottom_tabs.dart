import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:study_with_me/screens/add_screen.dart';
import 'package:study_with_me/screens/detail_screen.dart';
import 'package:study_with_me/screens/home_screen.dart';
import 'package:study_with_me/screens/alarm_screen.dart';
import 'package:study_with_me/screens/calender_screen.dart';

// bottom tabs 정리한 클래스
class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem(
      {required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomeScreen(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: CalenderScreen(),
          icon: Icon(Icons.calendar_month),
          title: Text("Calender-user"),
        ),
        TabNavigationItem(
          page: AlarmScreen(),
          icon: Icon(Icons.alarm),
          title: Text("alarm"),
        ),
      ];
}
