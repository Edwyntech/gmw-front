class UserAddModel {
  final String firstName;
  final String lastName;
  final String email;

  UserAddModel(this.firstName, this.lastName, this.email);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    return _data;
  }
}
