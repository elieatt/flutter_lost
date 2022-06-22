import 'dart:convert';

import '../../constants/env.dart';

import '../models/item.dart';
import 'package:http/http.dart' as http;

class ItemsNetworkService {
  Future<String> fetchItems(String token) async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(ENDPOINT + "/items"),
          headers: {"Authorization": 'bare $token'});
    } catch (e) {
      print("error");
      print(e);
      return '';
    }
    if (response.statusCode == 200) {
      //print(response.body);

      return response.body as String;
      //return parsedBody["items"] as List;
    }
    return '';
  }
}
