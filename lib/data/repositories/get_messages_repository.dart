import 'dart:convert';

import 'package:lostsapp/data/models/message.dart';
import 'package:lostsapp/data/network_services/get_messages_network_service,.dart';

class GetMessagesRepository {
  final List<Message> _recivedMessagesArray = [];
  final List<Message> _sentMessagesArray = [];
  List<int> _numberOfUnreadMessages = [0];
  final GetMessagesNetworkService gmns;
  GetMessagesRepository({
    required this.gmns,
  });

  Future<List<Message>?> getSentMessages(String token, String userId) async {
    final String messagesRaw = await gmns.getSentMessages(token, userId);
    if (messagesRaw == "errorHttp" || messagesRaw == "") {
      return null;
    }
    final Map<String, dynamic> decodedResponse = jsonDecode(messagesRaw);
    List<dynamic> messages = decodedResponse["messages"];
    _sentMessagesArray.length = 0;
    //print(messages);
    for (var element in messages) {
      _sentMessagesArray.add(Message.fromDyanmic(element));
    }
    return _sentMessagesArray;
  }

  Future<List<Message>?> getRecivedMessages(
      String token, String userId, bool refresh) async {
    if (refresh) {
      final String messagesRaw = await gmns.getRecivedMessages(token, userId);
      if (messagesRaw == "errorHttp" || messagesRaw == "") {
        return null;
      }

      final Map<String, dynamic> decodedResponse = jsonDecode(messagesRaw);

      List<dynamic> messages = decodedResponse["messages"] as List;
      _recivedMessagesArray.length = 0;
      _numberOfUnreadMessages[0] = 0;
      for (var element in messages) {
        Message recivedMessage = Message.fromDyanmic(element);
        if (recivedMessage.read == false) {
          _numberOfUnreadMessages[0]++;
        }
        _recivedMessagesArray.add(recivedMessage);
      }
      // print(_recivedMessagesArray.toString());
      return _recivedMessagesArray;
    }
    _numberOfUnreadMessages[0] = 0;
    for (Message msg in _recivedMessagesArray) {
      if (msg.read == false) {
        _numberOfUnreadMessages[0]++;
      }
    }
    return _recivedMessagesArray;
  }

  Future<bool> readMessage(String token, String messageId) async {
    String result = await gmns.readAmessage(token, messageId);
    if (result == '') {
      _recivedMessagesArray
          .firstWhere((element) => element.id == messageId)
          .read = true;
      return true;
    }
    return false;
  }

  int getNumOfUnReadMessages() {
    return _numberOfUnreadMessages[0];
  }
}
