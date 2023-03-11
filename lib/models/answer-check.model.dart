class AnswerCheckModel {
  final int questionId;
  final int answerId;
  final String userName;

  AnswerCheckModel(this.questionId, this.answerId, this.userName);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questionId'] = questionId;
    _data['answerId'] = answerId;
    _data['userName'] = userName;
    return _data;
  }
}
