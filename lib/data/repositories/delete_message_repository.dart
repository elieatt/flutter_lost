import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class DeleteMessageRepository {
  Future<String> deleteMessage(String token, String messageId) async {
    http.Response response;
    try {
      response = await http
          .delete(Uri.parse(ENDPOINT + "/messages/$messageId"), headers: {
        "Authorization": 'bare $token',
      });
    } catch (error) {
      print("error deleting message " + error.toString());
      return "failed";
    }
    if (response.statusCode == 201) {
      return "succeed";
    }
    return "failed";
  }
}
