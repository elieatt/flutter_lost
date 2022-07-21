import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class SendMessageRepository {
  Future<String> sendMessage(
      String token, String reciverId, String itemId, String messageText) async {
    http.Response response;
    Map<String, dynamic> reqBody = {
      "itemId": itemId,
      "messageText": messageText
    };
    try {
      response = await http.post(
          Uri.parse(ENDPOINT + "/messages/sendMessage/" + reciverId),
          headers: {
            "Authorization": 'bare $token',
            'Content-Type': "application/json"
          },
          body: jsonEncode(reqBody));
    } catch (e) {
      print(e);
      return 'errorHttp';
    }
    if (response.statusCode == 201) {
      return "Sent Successfully";
    }
    return "Cant Send";
  }
}
