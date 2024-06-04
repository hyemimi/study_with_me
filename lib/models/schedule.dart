class ScheduleModel {
  final String invite_code, location;
  String time;
  final int during;
  final int schedule_id;

  ScheduleModel.fromJson(Map<String, dynamic> json)
      : location = json['location'],
        during = json['during'],
        schedule_id = json['schedule_id'],
        invite_code = json['invite_code'],
        time = json['time'];
}
