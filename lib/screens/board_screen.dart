import 'package:flutter/material.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

import '../models/study.dart';

class BoardScreen extends StatefulWidget {
  StudyModel study;

  BoardScreen({required this.study});
  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
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
        body: Center(child: Text('레퍼런스 화면')));
  }
}
