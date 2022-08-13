import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class EditUserInfoNetworkService {
  Future<String> editUserInfo(String token, Map<String, String> info) async {
    http.Response respone;
    try {
      respone = await http.put(Uri.parse(ENDPOINT + "/users"),
          body: jsonEncode(info),
          headers: {
            "Authorization": 'bare $token',
            'Content-Type': "application/json"
          });
    } catch (e) {
      print("Http request error" + e.toString());
      return "errorHttp";
    }
    if (respone.statusCode == 401) {
      return "oldPassordIncorrect";
    } else if (respone.statusCode == 201) {
      return "successed";
    }
    return "failed";
  }

  Future<String> deleteUserAccount(String token) async {
    http.Response response;
    try {
      response = await http.delete(Uri.parse(ENDPOINT + "/users"), headers: {
        "Authorization": 'bare $token',
        'Content-Type': "application/json"
      });
    } catch (e) {
      print('http request error' + e.toString());
      return "errorHttp";
    }
    if (response.statusCode == 201) {
      return "successed";
    }
    return "failed";
  }
}
