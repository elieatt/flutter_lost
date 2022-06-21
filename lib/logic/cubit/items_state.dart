part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsFound extends ItemsState {
  final List<Item> items;

  ItemsFound({required this.items});
}

class ItemsNoItemsFound extends ItemsState {}
