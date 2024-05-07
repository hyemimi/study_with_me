import 'package:flutter/material.dart';
import 'package:study_with_me/tabs/home_tabs/tabs.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Text(
                'drawer',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(color: Colors.white)),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Tabs(selectedIndex: 0)),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Calender'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Tabs(selectedIndex: 1)),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('alarm'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Tabs(selectedIndex: 2)),
              ),
            },
          ),
        ],
      ),
    );
  }
}
