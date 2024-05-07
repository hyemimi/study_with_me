import 'package:flutter/material.dart';
import 'package:study_with_me/components/user_box.dart';
import 'package:study_with_me/models/user.dart';
import 'package:study_with_me/sidemenu/sidemenu.dart';

class MembersScreen extends StatelessWidget {
  List<UserModel> UserList = [
    UserModel.fromJson({
      'name': '이혜미',
      'email': 'hyemi7375@gmail.com',
      'route': 'http://10.0.2.2:3000/resources/user.png'
    }),
    UserModel.fromJson({
      'name': '이혜미',
      'email': 'hyemi7375@gmail.com',
      'route': 'http://10.0.2.2:3000/resources/user.png'
    }),
    UserModel.fromJson({
      'name': '이혜미',
      'email': 'hyemi7375@gmail.com',
      'route': 'http://10.0.2.2:3000/resources/user.png'
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text('Members'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.tertiary),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            },
          ),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: UserList.length,
                itemBuilder: (context, index) {
                  var user = UserList![index];
                  return UserBox(name: user.name, route: user.route);
                })));
  }
}
