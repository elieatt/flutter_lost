// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import 'package:lostsapp/logic/cubit/internet_cubit.dart';
import '../../data/models/item.dart';
import '../../data/repositories/items_repository.dart';
part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final InternetCubit _internetCubit;
  late InternetState _internetState = _internetCubit.state;
  bool _notFiltered = true;
  bool _posted = false;
/*      InternetConnected(connectionType: ConnectionType.wifi);*/
  late StreamSubscription internetStreamSub;

  final ItemsRepository repo;

  ItemsCubit(
    this._internetCubit,
    this.repo,
  ) : super(ItemsInitial()) {
    listenToInternetCubit();
  }
  bool getNotFilterdStatus() {
    return _notFiltered;
  }

  void setFiltredStatusTrue() {
    _notFiltered = false;
    Future.delayed(
      const Duration(microseconds: 50),
      () => _notFiltered = true,
    );
  }

  bool getPostStatus() {
    return _posted;
  }

  void posted() {
    _posted = true;
    Future.delayed(
      const Duration(milliseconds: 50),
      () => _posted = false,
    );
  }

  void listenToInternetCubit() {
    internetStreamSub = _internetCubit.stream.listen((event) {
      _internetState = event;
    });
  }

  void fetchItems(String token) {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchAllItems(token).then((items) {
      if (items == null) {
        emit(ItemsNoInternet());
        return;
      }
      if (items.isEmpty) {
        emit(ItemsNoItemsFound());
        return;
      }

      emit(ItemsFound(items: items));
    });
  }

  Future<void> fetchFoundItems(String token, bool refresh) async {
    // print("fetching found itmes");
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchFoundItems(token, refresh).then((foundItems) {
      if (foundItems == null) {
        emit(ItemsNoInternet());
        return;
      }
      if (foundItems.isEmpty) {
        emit(ItemsNoItemsFound());
        return;
      }
      emit(FoundItemsFound(foundItems: foundItems));
    });
  }

  Future<void> fetchLostItems(String token, bool refresh) async {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchLostItems(token, refresh).then((lostItems) {
      if (lostItems == null) {
        emit(ItemsNoInternet());
        return;
      }
      if (lostItems.isEmpty) {
        emit(ItemsNoItemsFound());
        return;
      }
      emit(LostItemsFound(lostItems: lostItems));
    });
  }

  Future<void> filterItems(String token, bool foundOrLost, String category,
      String governorate, bool refresh) async {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected && refresh) {
      emit(ItemsNoInternet());
      return;
    }
    List<Item>? filterdItemsFromRepo = await repo.filterItems(
        token, foundOrLost, category, governorate, refresh);
    if (filterdItemsFromRepo == null) {
      emit(ItemsNoInternet());
      return;
    }
    if (filterdItemsFromRepo.isEmpty) {
      emit(ItemsNoItemsFound());
      return;
    }
    emit(ItemsFilteredItems(filteredItems: filterdItemsFromRepo));
    return;
  }

  Future<void> getUserItem(String token, String userId, bool refresh) async {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    List<Item>? userItemsFromRepo =
        await repo.fetchUserItems(token, userId, refresh);
    if (userItemsFromRepo == null) {
      emit(ItemsNoInternet());
      return;
    }
    if (userItemsFromRepo.isEmpty) {
      emit(ItemsNoItemsFound());
      return;
    }
    emit(ItemsUserItemsFound(userItems: userItemsFromRepo));
    return;
  }

  @override
  Future<void> close() {
    internetStreamSub.cancel();
    return super.close();
  }

  @override
  void onChange(Change<ItemsState> change) {
    //print(change);
    super.onChange(change);
  }
}
