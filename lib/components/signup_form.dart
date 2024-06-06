import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  String _route = '';
  String _name = '';
  String _email = '';
  String _password = '';
  XFile? _image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _route = pickedFile.path;
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
      //가져온 이미지를 _image에 저장
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            // IconButton(
            //     onPressed: onPressed,
            //     icon: Icon(Icons.person_pin_sharp, size: 100)),
            buildPhotoArea(), SizedBox(height: 20),
            SizedBox(height: 5.0),
            CustomTextFormField("Name"),
            SizedBox(height: 10),
            CustomTextFormField("Email"),
            SizedBox(height: 10),
            CustomTextFormField("Password"),
            SizedBox(height: 10),
            submitButton(context),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/login')},
              child: const Text('로그인하기'),
            )
          ],
        ));
  }

  Widget buildPhotoArea() {
    return _image != null
        ? GestureDetector(
            onTap: () => getImage(ImageSource.gallery),
            child: SizedBox(
              width: 150,
              height: 150,
              child:
                  CircleAvatar(backgroundImage: FileImage(File(_image!.path))),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(ImageSource.gallery),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(150)),
              width: 150,
              height: 150,
            ));
  }

  // input
  Widget CustomTextFormField(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        SizedBox(height: 5.0),
        TextFormField(
            validator: (val) => val!.isEmpty ? "값을 입력해주세요" : null,
            obscureText: text == "Password" ? true : false,
            decoration: InputDecoration(
              hintText: "Enter $text",
            ),
            onSaved: (value) => {
                  text == 'Email'
                      ? _email = value!
                      : text == 'Password'
                          ? _password = value!
                          : _name = value!
                })
      ],
    );
  }

  // 폼 제출 버튼 위젯
  Widget submitButton(BuildContext context) {
    Future<dynamic> patchUserProfileImage(dynamic input) async {
      print("프로필 사진을 서버에 업로드 합니다.");
      var dio = new Dio();
      try {
        dio.options.contentType = 'multipart/form-data';
        dio.options.maxRedirects.isFinite;

        var response = await dio.post('http://10.0.2.2:3000/auth/uploadProfile',
            data: input);
        print('성공적으로 업로드했습니다');
        return response.data;
      } catch (e) {
        print(e);
      }
    }

    return ElevatedButton(
      onPressed: () async {
        if (_signupFormKey.currentState!.validate()) {
          _signupFormKey.currentState!.save();

          final response = await http.post(
              Uri.parse('http://10.0.2.2:3000/auth/register'),
              body: {"email": _email, "name": _name, "pwd": _password});
          if (response.statusCode == 200) {
            // 회원가입 성공
            if (_image != null) {
              // 프로필 이미지가 있다면 이미지 업로드
              var formData = FormData.fromMap({
                'image': await MultipartFile.fromFile(_route),
                'user_id': response.body
              });
              //print(response.body);
              patchUserProfileImage(formData);
            }

            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text('close'))
                      ],
                      title: Text('Study With Me'),
                      content: Text('회원가입 성공!'),
                    ));
          } else {
            // 회원가입 실패
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('close'))
                      ],
                      title: Text('Study With Me'),
                      content: Text('회원가입 실패 : 계정이 존재합니다'),
                    ));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          "SignUp",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
