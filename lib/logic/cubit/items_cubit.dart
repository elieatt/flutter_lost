// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lostsapp/constants/enums.dart';
import 'package:meta/meta.dart';

import 'package:lostsapp/logic/cubit/internet_cubit.dart';
import '../../data/models/item.dart';
import '../../data/repositories/items_repository.dart';
part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final InternetCubit _internetCubit;
  late InternetState _internetState = _internetCubit.state;
/*      InternetConnected(connectionType: ConnectionType.wifi);*/
  late StreamSubscription internetStreamSub;

  final ItemsRepository repo;

  ItemsCubit(
    this._internetCubit,
    this.repo,
  ) : super(ItemsInitial()) {
    listenToInternetCubit();
  }

  void listenToInternetCubit() {
    internetStreamSub = _internetCubit.stream.listen((event) {
      _internetState = event;
    });
  }

  void fetchItems(String token) {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      print("emitted no internet");
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchAllItems(token).then((items) {
      if (items.isEmpty) {
        emit(ItemsNoItemsFound());
        return;
      }
      print(items);
      emit(ItemsFound(items: items));
    });
  }

  void fetchFoundItems(String token) {
    // print("fetching found itmes");
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchFoundItems(token).then((foundItems) {
      if (foundItems.isEmpty) {
        emit(ItemsNoItemsFound());
        return;
      }
      emit(FoundItemsFound(foundItems: foundItems));
    });
  }

  void fetchLostItems(String token) {
    emit(ItemsInitial());
    if (_internetState is InternetDisconnected) {
      emit(ItemsNoInternet());
      return;
    }
    repo.fetchLostItems(token).then((lostItems) {
      if (lostItems.isEmpty) {
        print(lostItems);
        emit(ItemsNoItemsFound());
        return;
      }
      emit(LostItemsFound(lostItems: lostItems));
    });
  }

  @override
  Future<void> close() {
    internetStreamSub.cancel();
    return super.close();
  }

  @override
  void onChange(Change<ItemsState> change) {
    print(change);
    super.onChange(change);
  }
}
