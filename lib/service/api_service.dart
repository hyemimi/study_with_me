import 'dart:convert';

import 'package:study_with_me/models/coins.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev"; // test 용 api

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
}
