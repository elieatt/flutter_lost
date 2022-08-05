import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  String id;

  String email;

  String token;
  String userName;

  String phoneNumber;
  User(
      {required this.id,
      required this.email,
      required this.token,
      required this.phoneNumber,
      required this.userName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.from(User oldUserObj) {
    return User(
        id: oldUserObj.id,
        email: oldUserObj.email,
        token: oldUserObj.token,
        phoneNumber: oldUserObj.phoneNumber,
        userName: oldUserObj.userName);
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['id'] as String,
        email: map['email'] as String,
        token: map['token'] as String,
        phoneNumber: map['phoneNumber'] as String,
        userName: map["userName"] as String);
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(id: $id, email: $email, token: $token)';
}
