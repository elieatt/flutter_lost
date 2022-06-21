import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

import '../models/user.dart';

class AuthRepository {
  Future<Map<String, dynamic>?> signup(String email, String password) async {
    http.Response response;
    Map<String, dynamic> reqBody;
    reqBody = {"email": email, "password": password};
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/users/signup"),
          body: jsonEncode(reqBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
      return null;
    }
    print(response.body);
    Map<String, dynamic> parsedBody = jsonDecode(response.body);

    return parsedBody;
  }

  Future<Map<String, dynamic>?> login(String email, String password) async {
    User user;
    http.Response response;
    Map<String, dynamic> parsedBody;
    Map<String, dynamic> reqBody;
    reqBody = {"email": email, "password": password};
    try {
      response = await http.post(Uri.parse(ENDPOINT + "/users/login"),
          body: jsonEncode(reqBody),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
      return null;
    }
    parsedBody = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      user = User.fromMap(parsedBody["user"]);
      ////print("storing with shared prefrence in authrepo.dart 45");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user.id);
      //print("stored id ");
      await prefs.setString("token", user.token);
      await prefs.setString("email", user.email);
    }
    return (parsedBody);
  }

  Future<User?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? id, token, email;
    //print('id is ${id}');
    id = prefs.getString("id");
    token = prefs.getString("token");
    email = prefs.getString("email");
    if (id != null && token != null && email != null) {
      return User(email: email, id: id, token: token);
    }
    return null;
  }

  Future<void> deleteStoredToke() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('token');
  }
}
