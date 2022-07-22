import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class DeleteItemRepository {
  Future<String> deleteAnItem(String token, String itemId) async {
    http.Response respone;
    try {
      respone =
          await http.delete(Uri.parse(ENDPOINT + "/items/$itemId"), headers: {
        "Authorization": 'bare $token',
      });
    } catch (e) {
      return "failed";
    }
    if (respone.statusCode == 201) {
      return "succeed";
    }
    return "failed";
  }
}
