import 'package:flutter/material.dart';
import 'package:study_with_me/components/appbar.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: '스터디 생성'),
        body: Center(child: Text('추가화면')));
  }
}
