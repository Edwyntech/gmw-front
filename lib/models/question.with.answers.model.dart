import 'question.model.dart';
import 'answer.model.dart';

class QuestionWithAnswers {
  final Question question;
  final List<Answer> answers;

  QuestionWithAnswers({
    required this.question,
    required this.answers,
  });

  factory QuestionWithAnswers.fromJson(Map<String, dynamic> json) {
    return QuestionWithAnswers(
      question: Question.fromJson(json['question']),
      answers: (json['answers'] as List<dynamic>?)
          ?.map((item) => Answer.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question.toJson(),
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}
