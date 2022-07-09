// ignore: file_names
import 'package:http/http.dart' as http;
import 'package:lostsapp/constants/env.dart';

class GetMessagesNetworkService {
  Future<String> getSentMessages(String token, String userId) async {
    http.Response response;
    try {
      response = await http.get(
          Uri.parse(ENDPOINT + "/messages/getSentMessages/" + userId),
          headers: {
            "Authorization": 'bare $token',
            'Content-Type': "application/json"
          });
    } catch (e) {
      print(e);
      return 'errorHttp';
    }
    if (response.statusCode == 200) {
      //print(response.body);

      return response.body;
    }
    return '';
  }

  Future<String> getRecivedMessages(String token, String userId) async {
    http.Response response;
    try {
      response = await http.get(
          Uri.parse(ENDPOINT + "/messages/recivedMessages/" + userId),
          headers: {
            "Authorization": 'bare $token',
            'Content-Type': "application/json"
          });
    } catch (e) {
      print(e);
      return 'errorHttp';
    }
    if (response.statusCode == 200) {
      //print(response.body);

      return response.body;
    }
    return '';
  }
}
