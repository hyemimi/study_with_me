class StudyModel {
  final String description, invite_code, title, banner;
  String location, time;
  final int leader_id;
  int during;

  // 회원정보
  StudyModel.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        invite_code = json['invite_code'],
        title = json['title'],
        banner = json['banner'],
        location = json['location'] != null ? json['location'] : '',
        time = json['time'] != null ? json['time'] : '',
        during = json['during'] != null ? json['during'] : 0,
        leader_id = json['leader_id'];
}
