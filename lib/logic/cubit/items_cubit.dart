// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/item.dart';
import '../../data/repositories/items_repository.dart';

part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemsRepository repo;
  ItemsCubit(
    this.repo,
  ) : super(ItemsInitial());
  void fetchItems() {
    repo.fetchItems().then((items) {
      if (items.isEmpty) {
        emit(ItemsNoItemsFound());
      }
      print(items);
      emit(ItemsFound(items: items));
    });
  }
}
