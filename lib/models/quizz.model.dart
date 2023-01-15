import 'package:guess_my_w/models/answer.model.dart';

import 'Question.model.dart';
import 'answer.model.dart';

class Quizz {
  Question question;
  List<Answer> answers = [];

  Quizz({required this.question, required this.answers});

  Quizz.fromJson(Map<String, dynamic> json)
      : question = Question.fromJson(json['question']),
        answers = buildAnswers(json);
  // <Answer>[],
  //    json['answers'].forEach((v) {
  //   answers!.add(Answer.fromJson(v));
  // });

  // Quizz.fromJson(Map<String, dynamic> json) {
  //   answers = [];
  //   question = Question.fromJson(json['question']);
  //   if (json['answers'] != null) {
  //     answers = <Answer>[];
  //     json['answers'].forEach((v) {
  //       answers!.add(Answer.fromJson(v));
  //     });
  //   } else {
  //     answers = [];
  //   }
  // }

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
