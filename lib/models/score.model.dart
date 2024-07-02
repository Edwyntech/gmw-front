class Score {
  final int score;
  final int maxScore;
  final String text;

  Score({
    required this.score,
    required this.maxScore,
    required this.text,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      score: json['score'] is int ? json['score'] : 0,
      maxScore: json['maxScore'] is int ? json['maxScore'] : 0,
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'maxScore': maxScore,
      'text': text,
    };
  }
}
