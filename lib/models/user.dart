class UserModel {
  final String name, email, route;

  // 회원정보
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        route = json['route'];
}

List<UserModel> UserList = [
  UserModel.fromJson({
    'name': '이혜미',
    'email': 'hyemi7375@gmail.com',
    'route': 'localhost:3000/resources/user.png'
  }),
  UserModel.fromJson({
    'name': '이혜미',
    'email': 'hyemi7375@gmail.com',
    'route': 'localhost:3000/resources/user.png'
  }),
  UserModel.fromJson({
    'name': '이혜미',
    'email': 'hyemi7375@gmail.com',
    'route': 'localhost:3000/resources/user.png'
  })
];
