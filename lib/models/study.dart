class StudyModel {
  final String description, invite_code, title, banner;
  //final String location, time, during;
  final int leader_id;

  // 회원정보
  StudyModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        invite_code = json['invite_code'],
        title = json['title'],
        banner = json['banner'],
        // location = json['location'],
        // time = json['time'],
        leader_id = json['leader_id'];
  //during = json['during'];
}
