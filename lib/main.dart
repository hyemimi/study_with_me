import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/candy_global_variable.dart';
import 'package:study_with_me/pages/login_page.dart';
import 'package:study_with_me/pages/signup_page.dart';
import 'package:study_with_me/provider/user_provider.dart';
import 'package:study_with_me/screens/detail_screen.dart';
import 'package:study_with_me/tabs/home_tabs/tabs.dart';
import 'package:study_with_me/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
          navigatorKey: CandyGlobalVariable.naviagatorState,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          initialRoute: "/login",
          routes: {
            "/login": (context) => LoginPage(),
            "/signup": (context) => SignupPage(),
            "/home": (context) => Tabs(
                  selectedIndex: 0,
                )
          }),
    );
  }
}
