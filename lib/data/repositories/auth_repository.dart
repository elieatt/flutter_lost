import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

import '../models/user.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> signup(String email, String password,
      String phoneNumber, String userName) async {
    http.Response response;
    Map<String, dynamic> reqBody;

    reqBody = {
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "userName": userName
    };

    try {
      response = await http.post(Uri.parse(ENDPOINT + "/users/signup"),
          body: jsonEncode(reqBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
      return null;
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      //print(response.body);

      Map<String, dynamic> parsedBody = jsonDecode(response.body);

      return parsedBody;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    User user;
    http.Response response;
    Map<String, dynamic> parsedResult;
    Map<String, dynamic> reqBody;
    reqBody = {"email": email, "password": password};
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/users/login"),
          body: jsonEncode(reqBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print("error in login in auth repo");
      print(e);
      return null;
    }
    parsedResult = jsonDecode(response.body);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      user = User.fromMap(parsedResult["user"]);
      print(user);
      String timeOfExpire =
          DateTime.now().add(const Duration(days: 2)).toIso8601String();

      parsedResult["expire"] = timeOfExpire;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user.id);
      await prefs.setString("token", user.token);
      await prefs.setString("email", user.email);
      await prefs.setString("phoneNumber", user.phoneNumber);
      await prefs.setString("expire", timeOfExpire);
      await prefs.setString("userName", user.userName);
    }
    return (parsedResult);
  }

  Future<Map<String, dynamic>?> getStoredToken() async {
    //!

    final prefs = await SharedPreferences.getInstance();
    String? id, token, email, expire, phoneNumber, userName;

    id = prefs.getString("id");
    token = prefs.getString("token");
    email = prefs.getString("email");
    expire = prefs.getString("expire");
    phoneNumber = prefs.getString("phoneNumber");
    userName = prefs.getString("userName");

    if (id != null &&
        token != null &&
        email != null &&
        phoneNumber != null &&
        userName != null) {
      return {
        "user": User(
            email: email,
            id: id,
            token: token,
            phoneNumber: phoneNumber,
            userName: userName),
        "expire": expire
      };
    }
    return null;
  }

  Future<void> deleteStoredToke() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('token');
    await prefs.remove("expire");
    await prefs.remove("phoneNumber");
    await prefs.remove("userName");
  }
}
