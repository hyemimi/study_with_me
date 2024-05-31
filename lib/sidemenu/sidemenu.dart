import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/Schedule_screen.dart';
import 'package:study_with_me/screens/addUser_screen.dart';
import 'package:study_with_me/screens/adminSchedule_screen.dart';
import 'package:study_with_me/screens/board_screen.dart';
import 'package:study_with_me/screens/members_screen.dart';
import 'package:study_with_me/screens/voteSchedule_screen.dart';
import 'package:study_with_me/tabs/home_tabs/tabs.dart';

import '../models/study.dart';

class SideMenu extends StatefulWidget {
  StudyModel study;

  SideMenu({required this.study});

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late var isLeader = false;
  UserProvider _userProvider = Provider.of<UserProvider>(
      CandyGlobalVariable.naviagatorState.currentState!.context);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_userProvider.user_id == widget.study.leader_id) {
      isLeader = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var user_id = _userProvider.user_id;

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
                builder: (context) => MembersScreen(study: widget.study),
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
                builder: (context) => BoardScreen(study: widget.study),
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
                builder: (context) => ScheduleScreen(study: widget.study),
                fullscreenDialog: true,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.how_to_vote_outlined),
            title: Text('일정 투표'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => voteScheduleScreen(study: widget.study),
                fullscreenDialog: true,
              ),
            ),
          ),
          isLeader
              ? ListTile(
                  leading: Icon(Icons.edit_calendar_outlined),
                  title: Text('일정 등록'),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AdminScheduleScreen(study: widget.study),
                      fullscreenDialog: true,
                    ),
                  ),
                )
              : ListTile(
                  leading: SizedBox(),
                ),
          isLeader
              ? ListTile(
                  leading: Icon(Icons.send_to_mobile_outlined),
                  title: Text('유저 초대'),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUserScreen(
                          invite_code: widget.study.invite_code,
                          title: widget.study.title),
                      fullscreenDialog: true,
                    ),
                  ),
                )
              : ListTile(leading: SizedBox()),
        ],
      ),
    );
  }
}
