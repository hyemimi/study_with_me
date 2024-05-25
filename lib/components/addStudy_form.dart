import 'dart:convert';
//import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:study_with_me/screens/home_screen.dart';

class addStudyForm extends StatefulWidget {
  @override
  State<addStudyForm> createState() => _addStudyFormState();
}

class _addStudyFormState extends State<addStudyForm> {
  final addStudyFormKey = GlobalKey<FormState>();

  String _description = '';
  String _title = '';
  String _banner = "";
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _banner = pickedFile.path;
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
      //가져온 이미지를 _image에 저장
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
            key: addStudyFormKey,
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    buildPhotoArea(),
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        getImage(ImageSource
                            .gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
                      },
                    ),
                    CustomTextFormField("title"),
                    SizedBox(height: 20),
                    CustomTextFormField("description"),
                    SizedBox(height: 20),
                    submitButton(context),
                    SizedBox(height: 10),
                  ],
                ))));
  }

  Widget buildPhotoArea() {
    return _image != null
        ? Container(
            width: 250,
            height: 250,
            child: Image.file(File(_image!.path),
                fit: BoxFit.cover), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 250,
            height: 250,
            color: Colors.grey,
          );
  }

  Widget CustomTextFormField(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5.0),
        TextFormField(
            validator: (value) =>
                value!.isEmpty ? "Please enter some text" : null,
            maxLines: text == 'description' ? 5 : 1,
            decoration: InputDecoration(
              hintText: text == 'description'
                  ? 'ex) 알고리즘을 공부하는 스터디입니다. 매주 화요일 7시 비대면으로 진행됩니다'
                  : 'ex) 알고리즘 스터디',
            ),
            onSaved: (value) => {
                  text == 'description'
                      ? _description = value!
                      : _title = value!
                })
      ],
    );
  }

  // 폼 제출 버튼 위젯
  Widget submitButton(BuildContext context) {
    UserProvider _UserProvider = Provider.of<UserProvider>(context);

    Future<dynamic> patchUserProfileImage(dynamic input) async {
      print("프로필 사진을 서버에 업로드 합니다.");
      var dio = new Dio();
      try {
        dio.options.contentType = 'multipart/form-data';
        dio.options.maxRedirects.isFinite;

        var response = await dio.post('http://10.0.2.2:3000/study/postBanner',
            data: input);
        print('성공적으로 업로드했습니다');
        return response.data;
      } catch (e) {
        print(e);
      }
    }

    return ElevatedButton(
      onPressed: () async {
        if (addStudyFormKey.currentState!.validate()) {
          addStudyFormKey.currentState!.save();
          dynamic body = {
            "leader_id": _UserProvider.user_id,
            "title": _title,
            "description": _description,
          };
          body = jsonEncode(body);

          // 스터디 생성
          final response = await http.post(
              Uri.parse('http://10.0.2.2:3000/study/addStudies'),
              headers: {"Content-Type": "application/json"},
              body: body);
          if (response.statusCode == 200) {
            // 서버에 이미지 업로드

            if (_banner != "") {
              var formData = FormData.fromMap({
                'image': await MultipartFile.fromFile(_banner),
                'invite_code': response.body
              });
              print(response.body);
              patchUserProfileImage(formData);
            }

            showDialog(
                context: context,
                builder: (_) {
                  //clickPayment();
                  return AlertDialog(
                      title: Text('생성 완료'),
                      content: Text('$_title 스터디가 생성 되었습니다!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()))
                                .then((value) => setState(() {}));
                          },
                          child: Text('유저 초대'),
                        ),
                      ]);
                });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "SUBMIT",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

/*Widget buildButton() {
    return ElevatedButton(
      onPressed: () {
        getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
      },
      child: Text("사진 불러오기"),
    );
  }*/

// input
