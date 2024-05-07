import 'package:flutter/material.dart';
import 'package:study_with_me/screens/Schedule_screen.dart';
import 'package:study_with_me/screens/adminSchedule_screen.dart';
import 'package:study_with_me/screens/board_screen.dart';
import 'package:study_with_me/screens/members_screen.dart';
import 'package:study_with_me/tabs/home_tabs/tabs.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
                child: Text(
              'Study With Me',
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 25),
            )),
          ),
          ListTile(
            leading: Icon(Icons.people_alt),
            title: Text('구성원'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MembersScreen(),
                fullscreenDialog: true,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('레퍼런스 게시판'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BoardScreen(),
                fullscreenDialog: true,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books_rounded),
            title: Text('스터디 일정'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScheduleScreen(),
                fullscreenDialog: true,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit_calendar_outlined),
            title: Text('일정 등록'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScheduleScreen(),
                fullscreenDialog: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
