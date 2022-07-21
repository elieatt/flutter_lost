part of 'delete_message_cubit.dart';

@immutable
abstract class DeleteMessageState {}

class DeleteMessageInitial extends DeleteMessageState {}

class DeleteMessageProgress extends DeleteMessageState {}

class DeleteMessageSucceed extends DeleteMessageState {
  final String successMessage;

  DeleteMessageSucceed(this.successMessage);
}

class DeleteMessageFailed extends DeleteMessageState {
  final String errorMessage;

  DeleteMessageFailed(this.errorMessage);
}
