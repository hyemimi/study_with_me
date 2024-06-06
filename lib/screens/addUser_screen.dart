import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_with_me/components/addStudy_form.dart';
import 'package:study_with_me/components/home_appbar.dart';
import 'package:http/http.dart' as http;

class AddUserScreen extends StatefulWidget {
  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
  String invite_code;
  String title;

  AddUserScreen({required this.invite_code, required this.title});
}

class _AddUserScreenState extends State<AddUserScreen> {
  List<String> emailList = [];
  //List<String> userIdList = [];
  String email = "";
  String content = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void deleteEmail(String em) {
    setState(() {
      emailList.remove(em);
    });
  }

  void pressAddButton(e) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/study/getUser?email=${e}'));

    if (response.statusCode == 200) {
      emailList.add(e);
      //userIdList.add(response.body);
      email = "";
      setState(() {});
    } else if (response.statusCode == 401) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(content: Text('이미 가입된 유저입니다'), actions: [
              TextButton(
                  onPressed: () {
                    email = "";
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('확인')),
            ]);
          });
    } else {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(content: Text('존재하지 않는 유저입니다'), actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('확인')),
            ]);
          });
    }
  }

  void addMembers() async {
    // api 호출
    dynamic body = {
      "invite_code": widget.invite_code,
      "content": "${widget.title} 스터디 초대",
      "emailList": emailList
    };
    body = jsonEncode(body);

    // 알람 송신
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/study/sendNotification'),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      showDialog(
          context: context,
          builder: (_) {
            //clickPayment();
            return AlertDialog(content: Text('가입 요청을 보냈습니다'), actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  emailList = [];
                  email = "";
                  setState(() {});
                },
                child: Text('확인'),
              ),
            ]);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('유저 초대')),
        body: Expanded(
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 6),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.24),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: 25,
                        onPressed: () => pressAddButton(email),
                        icon: Icon(Icons.add))
                  ]),
              Expanded(
                child: ListView.separated(
                  itemCount: emailList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.email),
                                  Text(
                                    '${emailList[index]}',
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () =>
                                      deleteEmail(emailList[index]),
                                  icon: Icon(Icons.delete, size: 20))
                            ],
                          )),
                    ));
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Color(0xffDFDFDF),
                    height: 0,
                    indent: 30,
                    endIndent: 30,
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: ElevatedButton(
                          onPressed: () => addMembers(), child: Text("초대하기"))))
            ],
          ),
        ));
  }
}
