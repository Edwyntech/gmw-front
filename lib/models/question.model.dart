class Question {
  int id;
  String value;
  String imageUrl;

  Question({required this.id, required this.value, required this.imageUrl});

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        value = json['value'] ?? '',
        imageUrl = json['imageUrl'] ?? '';

  Map<String, dynamic> toJson() =>
      {'id': id, 'value': value, 'imageUrl': imageUrl};
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
