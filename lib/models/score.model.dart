class Score {
  int score;
  String text;

  Score({required this.score, required this.text});

  Score.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
    'score': score,
    'text': text,
  };
}
