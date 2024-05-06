import 'package:flutter/material.dart';
import 'package:study_with_me/components/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              SizedBox(height: 100.0),
              Center(
                  child: Text("Study With Me",
                      style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).colorScheme.primary))),
              SizedBox(height: 20.0),
              LoginForm()
            ])));
  }
}
