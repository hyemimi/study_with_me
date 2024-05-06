import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SignupForm extends StatefulWidget {
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  String _profileImage = '';
  String _name = '';
  String _email = '';
  String _password = '';
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            Icon(Icons.person_pin_sharp, size: 100),
            SizedBox(height: 20),
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
    return ElevatedButton(
      onPressed: () async {
        if (_signupFormKey.currentState!.validate()) {
          _signupFormKey.currentState!.save();

          final response = await http
              .post(Uri.parse('http://10.0.2.2:3000/register'), body: {
            "email": _email,
            "name": _name,
            "route": _profileImage,
            "pwd": _password
          });
          if (response.statusCode == 200) {
            // 회원가입 성공
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
