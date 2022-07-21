// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesProgress extends MessagesState {}

class MessagesSentMessagesFound extends MessagesState {
  final List<Message> sentMessages;

  MessagesSentMessagesFound({required this.sentMessages});
}

class MessagesrecivedMessagesFound extends MessagesState {
  final List<Message> recivedMessages;
  int unReadMessagesCount;

  MessagesrecivedMessagesFound({
    required this.recivedMessages,
    required this.unReadMessagesCount,
  });

  @override
  String toString() => ' unReadMessagesCount: $unReadMessagesCount)';
}

class MessagesNoRecivedMessagesFound extends MessagesState {}

class MessagesNoSentMessagesFound extends MessagesState {}

class MessagesNoInternet extends MessagesState {}
