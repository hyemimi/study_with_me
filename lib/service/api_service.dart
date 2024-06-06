import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/models/alarm.dart';
import 'package:study_with_me/models/board.dart';
import 'package:http/http.dart' as http;
import 'package:study_with_me/models/schedule.dart';
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/models/user.dart';
import 'package:study_with_me/models/userSchedule.dart';
import 'package:study_with_me/provider/user_provider.dart';

class ApiService {
  // get 호출을 관리합니다
  final String baseUrl = "http://10.0.2.2:3000"; // test 용 api

  /** 유저가 속한 스터디 모임을 조회합니다 */
  Future<List<StudyModel>> getStudies(context) async {
    late UserProvider _userProvider = Provider.of<UserProvider>(context);
    var user_id = _userProvider.user_id.toString();
    var dio = new Dio();
    List<StudyModel> studyInstances = [];

    final response = await http
        .get(Uri.parse('${baseUrl}/study/getStudies?user_id=${user_id}'));

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> studies = jsonDecode(response.body);
      for (var study in studies) {
        studyInstances.add(StudyModel.fromJson(study));
      }
      return studyInstances;
    }
    throw Error();
  }

  /** 유저가 속한 스터디 멤버들을 조회합니다 */
  Future<List<UserModel>> getMembers(String invite_code) async {
    List<UserModel> memberInstances = [];
    final response = await http.get(
        Uri.parse('${baseUrl}/study/getMembers?invite_code=${invite_code}'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        memberInstances.add(UserModel.fromJson(user));
      }
      return memberInstances;
    }
    throw Error();
  }

  /** 유저가 속한 스터디의 게시글들을 조회합니다 */
  Future<List<BoardModel>> getBoard(String invite_code) async {
    List<BoardModel> boardInstances = [];
    final response = await http
        .get(Uri.parse('${baseUrl}/board/getBoard?invite_code=${invite_code}'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> boards = jsonDecode(response.body);
      for (var board in boards) {
        boardInstances.add(BoardModel.fromJson(board));
      }
      return boardInstances;
    }
    throw Error();
  }

  /** 유저에게 온 알람을 확인합니다 */
  Future<List<AlarmModel>> getNotification(int user_id) async {
    List<AlarmModel> alarmInstances = [];
    final response = await http.get(Uri.parse(
        '${baseUrl}/study/getNotification?user_id=${user_id.toString()}'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> alarms = jsonDecode(response.body);
      for (var alarm in alarms) {
        alarmInstances.add(AlarmModel.fromJson(alarm));
      }
      return alarmInstances;
    }
    throw Error();
  }

  /** 스터디의 등록된 스케줄 리스트를 확인합니다 */
  Future<List<ScheduleModel>> getSchedule(String invite_code) async {
    List<ScheduleModel> scheduleInstances = [];
    final response = await http.get(Uri.parse(
        '${baseUrl}/calendar/getSchedule?invite_code=${invite_code}'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> schedule = jsonDecode(response.body);
      for (var it in schedule) {
        scheduleInstances.add(ScheduleModel.fromJson(it));
      }
      return scheduleInstances;
    }
    if (response.statusCode == 401) {
      return scheduleInstances;
    }
    throw Error();
  }

  /** 투표 완료한 유저들을 조회합니다 */
  Future<int> getCompletedMembers(String invite_code) async {
    final response = await http.get(Uri.parse(
        '${baseUrl}/calendar/getCompletedMembers?invite_code=${invite_code}'));
    print(response.body);

    if (response.statusCode == 200) {
      var res = json.decode(response.body);

      return res[0]['cnt'];
    }
    if (response.statusCode == 401) {
      return 0;
    }
    throw Error();
  }

  /** 유저의 전체 스터디 일정을 조회합니다 */
  Future<List<UserScheduleModel>> getAllSchedule(int user_id) async {
    List<UserScheduleModel> scheduleInstances = [];
    final response = await http.get(
        Uri.parse('${baseUrl}/calendar/getAllSchedule?user_id=${user_id}'));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> schedule = jsonDecode(response.body);
      for (var it in schedule) {
        scheduleInstances.add(UserScheduleModel.fromJson(it));
      }
      return scheduleInstances;
    }
    if (response.statusCode == 401) {
      return scheduleInstances;
    }
    throw Error();
  }
}
