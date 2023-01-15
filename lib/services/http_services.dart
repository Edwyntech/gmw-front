import 'dart:convert';

import 'package:guess_my_w/models/answer-check.model.dart';
import 'package:guess_my_w/models/quizz.model.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  final String baseUrl = "";

  Future<List<Quizz>> getQuizzList() async {
    var url = Uri.http('localhost:8081', '/quizzes');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)
            .map<Quizz>((item) => Quizz.fromJson(item))
            .toList();

        return res;
      } else {
        throw "Unable to retreive quiz list";
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> verifyAnswer(AnswerCheckModel answerCheckModel) async {
    var url = Uri.http('localhost:8081', '/quizzes/verify');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(answerCheckModel.toJson()));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return res;
    } else {
      throw "Unable to check Response ";
    }
  }
}
