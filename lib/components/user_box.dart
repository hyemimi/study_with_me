import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  final String name;
  final String route;

  const UserBox({super.key, required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        SizedBox(
          width: 40,
          height: 40,
          child: CircleAvatar(backgroundImage: NetworkImage(route)),
        ),
        SizedBox(width: 20),
        SizedBox(child: Text(name, textAlign: TextAlign.center)),
        SizedBox(height: 50)
      ],
    );
  }
}
