import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/components/login_form.dart';
import 'package:http/http.dart' as http;
import 'package:study_with_me/provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String isLogin = '';
  //bool is_logined= false;
  UserProvider _userProvider = Provider.of<UserProvider>(
      CandyGlobalVariable.naviagatorState.currentState!.context);

  // void checkIsLogined() async {
  //   final response =
  //       await http.get(Uri.parse('http://10.0.2.2:3000/auth/authCheck?email=${}'));
  //   var responseBody = jsonDecode(response.body) as Map<String, dynamic>;
  //
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       isLogin = responseBody["isLogin"];
  //       _userProvider.name = responseBody["name"];
  //       _userProvider.email = responseBody["email"];
  //       _userProvider.route = responseBody["route"];
  //       _userProvider.user_id = responseBody["user_id"];
  //     });
  //   } else {
  //     setState(() {
  //       isLogin = 'false';
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkIsLogined();
    // if (isLogin == 'true') {
    //   Navigator.pushReplacementNamed(context, '/home');
    // }
  }

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
