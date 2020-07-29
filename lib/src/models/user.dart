import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  final String phone;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.imageUrl,
    @required this.phone,
  });

  User.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        firstName = parsedJson["firstName"],
        lastName = parsedJson["lastName"],
        email = parsedJson["email"],
        phone = parsedJson["phone"],
        imageUrl = parsedJson["imageUrl"];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "imageUrl": imageUrl,
      "phone": phone
    };
  }
}
