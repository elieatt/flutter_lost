part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {}

class MessagesProgress extends MessagesState {}

class MessagesSentMessagesFound extends MessagesState {
  final List<Message> sentMessages;

  MessagesSentMessagesFound(this.sentMessages);
}

class MessagesrecivedMessagesFound extends MessagesState {
  final List<Message> recivedMessages;

  MessagesrecivedMessagesFound(this.recivedMessages);
}

class MessagesNoMessagesFound extends MessagesState {}

class MessagesNoInternet extends MessagesState {}
