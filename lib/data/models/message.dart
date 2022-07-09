// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lostsapp/data/models/item.dart';

class Message {
  final String id;
  final String messageText;
  final Map<String, dynamic>? sender;
  final Map<String, dynamic>? reciver;
  final Item item;
  Message({
    required this.id,
    required this.messageText,
    required this.sender,
    required this.reciver,
    required this.item,
  });
  factory Message.fromDyanmic(d) {
    return Message(
        id: d["_id"],
        messageText: d["messageText"],
        sender: d["sender"],
        reciver: d["reciver"],
        item: Item.fromDynamic([d["item"]]));
  }
}
