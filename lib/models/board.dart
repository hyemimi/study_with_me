class BoardModel {
  final String content, title, route, name;
  final int board_id;
  final String time;

  BoardModel.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        title = json['title'],
        time = json['time'],
        board_id = json['board_id'],
        route = json['route'],
        name = json['name'];
}
