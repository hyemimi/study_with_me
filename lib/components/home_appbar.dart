import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logoImage.png', width: 30, height: 30),
            Text(title, style: TextStyle(color: Colors.black)),
          ],
        ));
  }

  // appbar 사이즈 조절
  @override
  Size get preferredSize => Size.fromHeight(50);
}
