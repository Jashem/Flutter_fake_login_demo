import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../error/failure.dart';
import '../models/user.dart';
import '../utils/fake_http_client.dart';

class AuthChangeNotifier with ChangeNotifier {
  final _httpClient = FakeHttpClient();
  User user;

  bool get isAuthenticated {
    return user != null;
  }

  Future<void> login(String email, String password) async {
    try {
      final responseBody = await _httpClient.login(email, password);
      user = User.fromJson(json.decode(responseBody));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user", json.encode(user.toMap()));
    } on SocketException {
      throw Failure('No Internet connection');
    } on HttpException catch (e) {
      if (e.message == "401") {
        throw Failure("Email or Password is wrong!");
      }
      throw Failure("Server error");
    } on FormatException {
      throw Failure("Bad response format");
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("user")) {
      return false;
    }

    final extractedUser =
        json.decode(prefs.getString("user")) as Map<String, dynamic>;

    user = User.fromJson(extractedUser);
    notifyListeners();

    return true;
  }

  Future<void> updateUserInfo(
      {@required String firstName,
      @required String lastName,
      @required String email,
      @required String phone,
      @required String imagePath}) async {
    user = User(
      id: user.id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      imageUrl: imagePath,
      phone: phone,
    );

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(user.toMap()));
    notifyListeners();
  }
}
