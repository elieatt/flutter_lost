import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class AuthNetworkService {
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
    //print(response.body);
    Map<String, dynamic> parsedBody = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return parsedBody;
    } else {
      return null;
    }
  }
}
