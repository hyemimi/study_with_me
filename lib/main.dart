import 'package:flutter/material.dart';
import 'package:study_with_me/pages/home_page.dart';
import 'package:study_with_me/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/login",
        routes: {
          "/login": (context) => LoginPage(),
          "/home": (context) => HomePage()
        });
  }
}
