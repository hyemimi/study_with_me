import 'package:flutter/material.dart';
import 'package:study_with_me/components/addStudy_form.dart';
import 'package:study_with_me/components/home_appbar.dart';

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('스터디 생성')),
        body: Expanded(child: addStudyForm()));
  }
}
