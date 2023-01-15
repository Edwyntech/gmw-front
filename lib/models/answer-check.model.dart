class AnswerCheckModel {
  final int questionId;
  final int answerId;

  AnswerCheckModel(this.questionId, this.answerId);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questionId'] = questionId;
    _data['answerId'] = answerId;
    return _data;
  }
}
