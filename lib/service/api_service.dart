import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:study_with_me/models/board.dart';
import 'package:study_with_me/models/coins.dart';
import 'package:http/http.dart' as http;
import 'package:study_with_me/models/study.dart';
import 'package:study_with_me/models/user.dart';
import 'package:study_with_me/provider/user_provider.dart';

class ApiService {
  // get 호출을 관리합니다
  final String baseUrl = "http://10.0.2.2:3000"; // test 용 api

  Future<List<WebtoonModel>> getCoins() async {
    List<WebtoonModel> coinInstances = [];
    final url = Uri.parse('$baseUrl/today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> coins = jsonDecode(response.body);
      for (var coin in coins) {
        final instance = WebtoonModel.fromJson(coin);
        coinInstances.add(instance);
      }
      return coinInstances;
    }
    throw Error();
  }

  /** 유저가 속한 스터디 모임을 조회합니다 */
  Future<List<StudyModel>> getStudies(context) async {
    late UserProvider _userProvider = Provider.of<UserProvider>(context);
    var user_id = _userProvider.user_id.toString();
    var dio = new Dio();
    List<StudyModel> studyInstances = [];

    // final queryParameters = {'user_id': user_id};
    // final uri =
    //     Uri.http('http://10.0.2.2:3000', '/study/getStudies', queryParameters);
    //final response = await http.get(uri,
    //     headers: {HttpHeaders.acceptCharsetHeader: 'application/json'});

    //dynamic queryParameter = {"user_id": 20};
    //queryParameter = jsonEncode(queryParameter);

    // 스터디 생성
    // final response = await dio.get('http://localhost:3000/study/getStudies',
    //     //headers: {"Content-Type": "application/json"},
    //     queryParameters: queryParameter);

    final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/study/getStudies?user_id=${user_id}'));
    //final url = Uri.parse('$baseUrl/study/getStudies');
    // final url = Uri.parse('http://10.0.2.2:3000/study/getStudies?user_id=20');
    //final response = await http.get(url);
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
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:3000/study/getMembers?invite_code=${invite_code}'));
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
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:3000/study/getBoard?invite_code=${invite_code}'));
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
}
