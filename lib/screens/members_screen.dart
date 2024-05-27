import 'package:flutter/material.dart';
import 'package:study_with_me/components/user_box.dart';
import 'package:study_with_me/models/user.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

import '../models/study.dart';

class MembersScreen extends StatefulWidget {
  StudyModel study;

  MembersScreen({required this.study});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late List<UserModel> members = [];

  void waitForMembers() async {
    members = await ApiService().getMembers(widget.study.invite_code);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(study: widget.study),
      appBar: AppBar(
        title: Text('Members'),
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
      body: Expanded(
        child: ListView.separated(
          itemCount: members.length,
          itemBuilder: (context, index) {
            var member = members![index];
            return members.length > 0
                ? UserBox(
                    name: member.name, route: member.route, email: member.email)
                : Text("");
          },
          separatorBuilder: (context, index) => const Divider(
            color: Color(0xffDFDFDF),
            height: 0,
            indent: 16,
            endIndent: 1,
          ),
        ),
      ),
    );
  }
}
