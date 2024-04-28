import 'package:flutter/material.dart';
import 'package:study_with_me/screens/alarm_screen.dart';
import 'package:study_with_me/screens/home_screen.dart';
import 'package:study_with_me/screens/CalenderScreen.dart';
import 'package:study_with_me/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [HomeScreen(), CalenderScreen(), AlarmScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          const BottomNavigationBarItem(
              label: '캘린더', icon: Icon(Icons.calendar_month)),
          const BottomNavigationBarItem(label: '알람', icon: Icon(Icons.alarm)),
        ],
      ),
    );
  }
}
