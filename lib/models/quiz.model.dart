import 'package:guess_my_w/models/question.with.answers.model.dart';

class Quiz {
  int id;
  String description;
  bool done;
  List<QuestionWithAnswers> questionWithAnswers = [];

  Quiz({required this.id, required this.description, required this.done, required this.questionWithAnswers});

  Quiz.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        done = json['done'],
        questionWithAnswers = buildQuestionWithAnswers(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questionWithAnswers != null) {
      data['id'] = this.id;
    }
    if (questionWithAnswers != null) {
      data['questionWithAnswers'] =
          questionWithAnswers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

buildQuestionWithAnswers(Map<String, dynamic> json) {
  List<QuestionWithAnswers> questionWithAnswers = [];
  if (json['questionWithAnswers'] != null) {
    questionWithAnswers = <QuestionWithAnswers>[];
    json['questionWithAnswers'].forEach((v) {
      questionWithAnswers!.add(QuestionWithAnswers.fromJson(v));
    });
  } else {
    questionWithAnswers = [];
  }
  return questionWithAnswers;
}
