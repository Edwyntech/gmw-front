import 'dart:convert';

import 'package:guess_my_w/models/answer-check.model.dart';
import 'package:guess_my_w/models/question.with.answers.model.dart';
import 'package:guess_my_w/models/quiz.model.dart';
import 'package:http/http.dart' as http;

import '../models/user-add.model.dart';

class HttpServices {
  final String baseUrl = "";

  Future<Quiz> getQuizzList() async {
    var url = Uri.http('localhost:8081', '/quizzes/default');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var res = Quiz.fromJson(jsonDecode(response.body));
        print(res);

        return res;
      } else {
        throw "Unable to retreive quiz list";
      }
    } catch (e) {
      throw "Unable to check Response ";
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

  Future<void> addUser(UserAddModel userAddModel) async {
    var url = Uri.http('localhost:8081', '/users');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userAddModel.toJson()));
    //
    // if (response.statusCode == 200) {
    //   var res = jsonDecode(response.body);
    //   return res;
    // } else {
    //   throw "Unable to check Response ";
    // }
  }
}
