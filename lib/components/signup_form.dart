import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  final _signupFormKey = GlobalKey<FormState>();
  String _profileImage = '';
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            Icon(Icons.person_pin_sharp, size: 100),
            SizedBox(height: 20),
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
            validator: (value) =>
                value!.isEmpty ? "Please enter some text" : null,
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
          debugPrint('$_name, $_email, $_password 회원가입 시도');
          Navigator.pushNamed(context, '/home');
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
