import 'package:flutter/material.dart';
import 'package:study_with_me/components/login_form.dart';
import 'package:study_with_me/components/signup_form.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              SizedBox(height: 100.0),
              SignupForm(),
            ])));
  }
}
