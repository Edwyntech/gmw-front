import 'dart:convert';
import 'package:guess_my_w/models/answer-check.model.dart';
import 'package:guess_my_w/models/score.model.dart';
import 'package:http/http.dart' as http;

import '../models/quiz.model.dart';
import '../models/user-add.model.dart';

class HttpServices {
  final String baseUrl = "";

  Future<List<Quiz>> getQuizList() async {
    var url = Uri.http('localhost:8081', '/quizzes');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)
            .map<Quiz>((item) => Quiz.fromJson(item))
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

  Future<Score> getScore(String name, int quizId) async {
    Map<String, String> queryParameters = {
      "quizId": quizId.toString()
    };
    var url = Uri.http('localhost:8081', '/users/$name/score', queryParameters);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var res = Score.fromJson(jsonDecode(response.body));
      return res;
    } else {
      throw "Unable to check Response ";
    }
  }

  Future<void> addUser(UserAddModel userAddModel) async {
    var url = Uri.http('localhost:8081', '/users');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userAddModel.toJson()));
  }
}
