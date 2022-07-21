// ignore_for_file: public_member_api_docs, sort_constructors_first

class Message {
  final String id;
  final String messageText;
  final Map<String, dynamic> sender;
  final Map<String, dynamic> reciver;
  final Map<String, dynamic> item;
  bool read;
  Message(
      {required this.id,
      required this.messageText,
      required this.sender,
      required this.reciver,
      required this.item,
      required this.read});
  factory Message.fromDyanmic(d) {
    return Message(
        id: d["id"] as String,
        messageText: d["messageText"] as String,
        sender: d["sender"],
        reciver: d["reciver"],
        item: d["item"],
        read: d["read"]);
  }

  @override
  String toString() {
    return 'Message(id: $id, messageText: $messageText, sender: $sender, reciver: $reciver, item: $item, read: $read)';
  }
}
