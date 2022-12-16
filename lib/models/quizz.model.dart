class Quizz {
  Question? question;
  List<Answers>? answers;

  Quizz({this.question, this.answers});

  Quizz.fromJson(Map<String, dynamic> json) {
    question =
        json['question'] != null ? Question.fromJson(json['question']) : null;
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (question != null) {
      data['question'] = question!.toJson();
    }
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  int? id;
  String? value;
  String? imageUrl;

  Question({this.id, this.value, this.imageUrl});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Answers {
  int? id;
  String? value;

  Answers({this.id, this.value});

  Answers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['value'] = value;
    return data;
  }
}
