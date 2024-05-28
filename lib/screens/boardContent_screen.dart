import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_with_me/components/home_appbar.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

import '../models/board.dart';

class BoardContentScreen extends StatefulWidget {
  @override
  State<BoardContentScreen> createState() => _BoardContentScreenState();
  BoardModel board;
  BoardContentScreen({required this.board});
}

class _BoardContentScreenState extends State<BoardContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.board.title), backgroundColor: Colors.white),
        body: Expanded(
            child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Color(0xffF7ECB4).withOpacity(0.24)),
          child: SingleChildScrollView(
              child: Text(
            widget.board.content,
            style: TextStyle(fontSize: 20),
          )),
        )));
  }
}
