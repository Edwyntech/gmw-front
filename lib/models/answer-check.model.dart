class AnswerCheckModel {
  final int questionId;
  final int answerId;
  final String userEmail;

  AnswerCheckModel(this.questionId, this.answerId, this.userEmail);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questionId'] = questionId;
    _data['answerId'] = answerId;
    _data['email'] = userEmail;
    return _data;
  }
}
