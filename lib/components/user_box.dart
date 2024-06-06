import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  final String name;
  final String route;
  final String email;

  const UserBox(
      {super.key,
      required this.name,
      required this.route,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
                foregroundImage: NetworkImage(
                    'http://10.0.2.2:3000/resources/profileImage/${route}'),
                backgroundImage: const AssetImage('assets/logoImage.png'))),
        SizedBox(width: 20),
        SizedBox(width: 100, child: Text(name, textAlign: TextAlign.center)),
        SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.email),
                SizedBox(child: Text(email, textAlign: TextAlign.center))
              ],
            ),
          ),
        ),
        SizedBox(height: 50)
      ],
    );
  }
}
