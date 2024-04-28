import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [const Text('Study With Me')],
          ),
        ),
        body: Center(child: Text('home 화면')));
  }
}
