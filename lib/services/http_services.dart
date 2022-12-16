import 'dart:convert';

import 'package:guess_my_w/models/quizz.model.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  Future<List<Quizz>> getQuizzList() async {
    var url = Uri.http('localhost:8080', '/api/vehicles');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)
            .map<Quizz>((item) => Quizz.fromJson(item))
            .toList();
        return res;
      } else {
        throw "Unable to retreive vehicles";
      }
    } catch (e) {
      return [];
    }
  }
}
