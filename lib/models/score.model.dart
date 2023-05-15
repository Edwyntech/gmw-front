class Score {
  int score;
  int maxScore;
  String text;

  Score({required this.score, required this.maxScore, required this.text});

  Score.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        maxScore = json['maxScore'],
        text = json['text']
  ;

  Map<String, dynamic> toJson() => {
    'score': score,
    'maxScore': maxScore,
    'text': text,
  };
}
