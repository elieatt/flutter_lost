// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'items_cubit.dart';

@immutable
abstract class ItemsState {}

class ItemsInitial extends ItemsState {}

class ItemsFound extends ItemsState {
  final List<Item> items;

  ItemsFound({required this.items});
}

class FoundItemsFound extends ItemsState {
  final List<Item> foundItems;
  FoundItemsFound({required this.foundItems});
}

class LostItemsFound extends ItemsState {
  final List<Item> lostItems;
  LostItemsFound({required this.lostItems});

  @override
  String toString() => 'LostItemsFound(lostItems: $lostItems)';
}

class ItemsFilteredItems extends ItemsState {
  final List<Item> filteredItems;
  ItemsFilteredItems({
    required this.filteredItems,
  });
}

class ItemsUserItemsFound extends ItemsState {
  final List<Item> userItems;
  ItemsUserItemsFound({
    required this.userItems,
  });
}

class ItemsNoItemsFound extends ItemsState {}

class ItemsNoInternet extends ItemsState {}
