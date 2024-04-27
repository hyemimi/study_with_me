import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              SizedBox(height: 100.0),
              Text("Study With Me", style: TextStyle(fontSize: 40)),
              SizedBox(height: 20.0)
            ])));
  }
}
