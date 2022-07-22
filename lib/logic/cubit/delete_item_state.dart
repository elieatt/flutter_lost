part of 'delete_item_cubit.dart';

@immutable
abstract class DeleteItemState {}

class DeleteItemInitial extends DeleteItemState {}

class DeleteItemProgress extends DeleteItemState {}

class DeleteItemFailed extends DeleteItemState {
  final String failedMessage;

  DeleteItemFailed(this.failedMessage);
}

class DeleteItemSuccess extends DeleteItemState {
  final String successMessage;

  DeleteItemSuccess(this.successMessage);
}
