import 'dart:io';

class User {
  String email;

  String name;

  String userID;

  User({this.email = '', this.name = '', this.userID = ''});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
      email: parsedJson['email'] ?? '',
      name: parsedJson['name'] ?? '',
      userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'name': this.name,
      'id': this.userID,
    };
  }
}
