class AlarmModel {
  final String content, invite_code;
  final int notify_id;
  final int isChecked;

  AlarmModel.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        notify_id = json['notify_id'],
        invite_code = json['invite_code'],
        isChecked = json['isChecked'];
}
