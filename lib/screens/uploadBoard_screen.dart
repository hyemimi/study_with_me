import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/board_screen.dart';

class UploadBoardScreen extends StatefulWidget {
  StudyModel study;

  @override
  State<UploadBoardScreen> createState() => _UploadBoardScreenState();

  UploadBoardScreen({required this.study});
}

class _UploadBoardScreenState extends State<UploadBoardScreen> {
  String title = "";
  String content = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void uploadContent(user_id) async {
    await http
        .post(Uri.parse('http://10.0.2.2:3000/study/uploadContent'), body: {
      "user_id": user_id.toString(),
      "title": title,
      "content": content,
      "invite_code": widget.study.invite_code
    }).then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BoardScreen(study: widget.study)))
            .then((value) => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    var user_id = Provider.of<UserProvider>(context).user_id;

    return Scaffold(
        appBar: AppBar(title: Text('게시글 작성')),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.0),
                      TextFormField(
                        onChanged: (value) {
                          title = value;
                          setState(() {});
                        },
                        validator: (value) =>
                            value!.isEmpty ? "Please enter some text" : null,
                        decoration: InputDecoration(
                          hintText: "title",
                        ),
                      )
                    ])),
            TextFormField(
              onChanged: (value) {
                content = value;
                setState(() {});
              },
              maxLines: 15,
              decoration: InputDecoration(
                hintText: '내용',
                filled: true,
                fillColor: Color(0xffF7ECB4).withOpacity(0.24),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () => {uploadContent(user_id)}, child: Text("저장"))
          ],
        )));
  }
}
