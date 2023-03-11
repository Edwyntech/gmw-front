import 'package:guess_my_w/models/answer.model.dart';

import 'question.model.dart';
import 'answer.model.dart';

class QuestionWithAnswers {
  Question question;
  List<Answer> answers = [];

  QuestionWithAnswers({required this.question, required this.answers});

  QuestionWithAnswers.fromJson(Map<String, dynamic> json)
      : question = Question.fromJson(json['question']),
        answers = buildAnswers(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

buildAnswers(Map<String, dynamic> json) {
  List<Answer> answers = [];
  if (json['answers'] != null) {
    answers = <Answer>[];
    json['answers'].forEach((v) {
      answers!.add(Answer.fromJson(v));
    });
  } else {
    answers = [];
  }
  return answers;
}
