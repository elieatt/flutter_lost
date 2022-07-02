part of 'post_item_cubit.dart';

@immutable
abstract class PostItemState {}

class PostItemInitial extends PostItemState {}

class PostItemFailed extends PostItemState {
  final String message;

  PostItemFailed(this.message);
}

class PostItemSuccessed extends PostItemState {}

class PostItemProgress extends PostItemState {}
