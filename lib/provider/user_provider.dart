import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int _user_id = 0;
  String _email = "";
  String _name = "";
  String _route = "";

  String get email => _email;
  String get name => _name;
  int get user_id => _user_id;
  String get route => _route;

  void set email(String email) {
    _email = email;
    notifyListeners();
  }

  void set name(String name) {
    _name = name;
    notifyListeners();
  }

  void set route(String route) {
    _route = route;
    notifyListeners();
  }

  void set user_id(int user_id) {
    _user_id = user_id;
    notifyListeners();
  }
}
