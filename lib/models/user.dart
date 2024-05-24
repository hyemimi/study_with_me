class UserModel {
  final String name, email, route;
  final int user_id;

  // 회원정보
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        route = json['route'],
        user_id = json['user_id'];
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
