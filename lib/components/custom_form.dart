import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField("email"),
            SizedBox(height: 20),
            CustomTextFormField("Password"),
            SizedBox(height: 20),
            submitButton(context),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, '/home')},
              child: const Text('계정이 없으신가요? 가입하기'),
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
            onSaved: (value) =>
                {text == 'email' ? _email = value! : _password = value!})
      ],
    );
  }

  // 폼 제출 버튼 위젯
  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          debugPrint('$_email, $_password 로그인 시도');
          Navigator.pushNamed(context, '/home');
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
