import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:study_with_me/models/board.dart';
import 'package:study_with_me/screens/boardContent_screen.dart';
import 'package:study_with_me/screens/uploadBoard_screen.dart';
import 'package:study_with_me/service/api_service.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

import '../models/study.dart';

class BoardScreen extends StatefulWidget {
  StudyModel study;

  BoardScreen({required this.study});
  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late List<BoardModel> boards = [];
  void waitForBoard() async {
    boards = await ApiService().getBoard(widget.study.invite_code);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(study: widget.study),
        appBar: AppBar(
          title: Text('References'),
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
          padding: const EdgeInsets.all(2),
          child: Column(children: [
            Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UploadBoardScreen(study: widget.study),
                            //fullscreenDialog: true,
                          ),
                        ),
                    child: Text("작성하기"))),
            Expanded(
              child: ListView.separated(
                itemCount: boards.length,
                itemBuilder: (context, index) {
                  var board = boards![index];
                  return boards.length > 0
                      ? GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BoardContentScreen(board: boards![index]),
                                fullscreenDialog: true,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 200,
                                  child: Text(board.title,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.start)),
                              //SizedBox(width: 150),
                              Column(
                                children: [
                                  SizedBox(
                                      child: Text(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(board.time)
                                                  .add(Duration(hours: 9))),
                                          textAlign: TextAlign.center)),
                                  Row(children: [
                                    SizedBox(width: 10),
                                    Text(
                                      board.name,
                                    )
                                  ])
                                ],
                              ),
                            ],
                          ))
                      : Text("게시물이 없습니다");
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Color(0xffDFDFDF),
                  height: 2,
                  indent: 0,
                  endIndent: 0,
                ),
              ),
            ),
          ]),
        ));
  }
}
