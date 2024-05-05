class UserModel {
  final String name, email, pwd, route;

  // 회원정보
  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        pwd = json['pwd'],
        route = json['route'];
}
