class Answer {
  final int id;
  final String value;
  final String imageUrl;

  Answer({
    required this.id,
    required this.value,
    required this.imageUrl,
  });

  Answer.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        value = json['value'] ?? '',
        imageUrl = json['imageUrl'] ?? '';

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['value'] = value;
    _data['imageUrl'] = imageUrl;
    return _data;
  }
}
