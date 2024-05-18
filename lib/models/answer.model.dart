class Answer {
  final int id;
  final String value;
  final String imageUrl;

  Answer({
    required this.id,
    required this.value,
    required this.imageUrl,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] is int ? json['id'] : 0,
      value: json['value'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'imageUrl': imageUrl,
    };
  }
}
