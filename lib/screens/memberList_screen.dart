import 'package:flutter/material.dart';

class MemberlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [const Text('Members')],
          ),
        ),
        body: Center(child: Text('memberlist 화면')));
  }
}
