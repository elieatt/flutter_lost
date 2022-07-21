// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'send_message_cubit.dart';

@immutable
abstract class SendMessageState {}

class SendMessageInitial extends SendMessageState {}

class SendMessageProgress extends SendMessageState {}

class SendMessageFailed extends SendMessageState {
  final String message;
  SendMessageFailed({
    required this.message,
  });
}

class SendMessageSuccessed extends SendMessageState {}
