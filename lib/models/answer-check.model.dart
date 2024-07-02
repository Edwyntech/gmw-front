class AnswerCheckModel {
  final int questionId;
  final int answerId;
  final String userEmail;

  AnswerCheckModel({
    required this.questionId,
    required this.answerId,
    required this.userEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answerId': answerId,
      'email': userEmail,
    };
  }
}
