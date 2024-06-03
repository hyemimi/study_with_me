class UserScheduleModel {
  final String title, location;
  final String time;
  final int during;

  UserScheduleModel.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        during = json['during'],
        title = json['title'],
        time = json['time'];
}
