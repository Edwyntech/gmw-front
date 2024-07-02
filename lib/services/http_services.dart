import 'dart:convert';
import 'package:guess_my_w/models/answer-check.model.dart';
import 'package:guess_my_w/models/score.model.dart';
import 'package:http/http.dart' as http;
import '../models/quiz.model.dart';
import '../models/user-add.model.dart';

class HttpServices {
  static const String _baseUrl = "gmw.api.edwyn.info";

  Future<List<Quiz>> getQuizList(String email) async {
    final queryParameters = {"email": email};
    final url = Uri.https(_baseUrl, '/quizzes/user', queryParameters);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final res = (jsonDecode(response.body) as List<dynamic>)
            .map((item) => Quiz.fromJson(item))
            .toList();
        return res;
      } else {
        throw "Unable to retrieve quiz list";
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> verifyAnswer(AnswerCheckModel answerCheckModel) async {
    final url = Uri.https(_baseUrl, '/quizzes/verify');
    final response = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(answerCheckModel.toJson()));

    if (response.statusCode == 200) {
      final res = jsonDecode(response.body);
      return res;
    } else {
      throw "Unable to check Response";
    }
  }

  Future<Score> getScore(String email, int quizId) async {
    final queryParameters = {"email": email, "quizId": quizId.toString()};
    final url = Uri.https(_baseUrl, '/users/score', queryParameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = Score.fromJson(jsonDecode(response.body));
      return res;
    } else {
      throw "Unable to check   Response";
    }
  }

  Future<int> addUser(UserAddModel userAddModel) async {
    final url = Uri.https(_baseUrl, '/users');
    final response = await http.post(url,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(userAddModel.toJson()));
    return response.statusCode;
  }
}