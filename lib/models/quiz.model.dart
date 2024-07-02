import 'package:guess_my_w/models/question.with.answers.model.dart';
import 'package:guess_my_w/models/score.model.dart';

class Quiz {
  final int id;
  final String description;
  final bool done;
  final List<QuestionWithAnswers> questionWithAnswers;
  final Score? score;

  Quiz({
    required this.id,
    required this.description,
    required this.done,
    required this.questionWithAnswers,
    required this.score,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      description: json['description'],
      done: json['done'],
      questionWithAnswers: _buildQuestionWithAnswers(json),
      score: json['score'] != null ? Score.fromJson(json['score']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'done': done,
      'questionWithAnswers': questionWithAnswers.map((v) => v.toJson()).toList(),
      'score': score?.toJson(),
    };
  }

  static List<QuestionWithAnswers> _buildQuestionWithAnswers(Map<String, dynamic> json) {
    if (json['questionWithAnswers'] == null) {
      return [];
    }
    return (json['questionWithAnswers'] as List<dynamic>)
        .map((item) => QuestionWithAnswers.fromJson(item))
        .toList();
  }
}
