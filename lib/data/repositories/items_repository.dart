import 'dart:async';
import 'dart:convert';

import '../models/item.dart';
import '../network_services/items_netwroks_service.dart';

class ItemsRepository {
  int fetchingFromServerCount = 0;
  final ItemsNetworkService service;
  final List<Item> _allItemsArray = [];
  final List<Item> _foundItemsArray = [];
  final List<Item> _lostItemsArray = [];
  final List<Item> _filteredItemsArray = [];

  ItemsRepository(this.service);

  void clearArrays() {
    _allItemsArray.length = 0;
    _foundItemsArray.length = 0;
    _lostItemsArray.length = 0;
    _filteredItemsArray.length = 0;
  }

  Future<List<Item>?> fetchAllItems(String token) async {
    final String itemsRaw = await service.fetchItems(token);
    if (itemsRaw == "errorHttp") {
      return null;
    }
    fetchingFromServerCount++;

    if (itemsRaw == '') {
      return [];
    }
    final Map<String, dynamic> decodedResponse = jsonDecode(itemsRaw);
    //print(decodedResponse["items"]);
    List<dynamic> items = decodedResponse["items"];
    //print(items);
    clearArrays();
    for (var element in items) {
      Item fetchedItem = Item.fromDynamic(element);
      _allItemsArray.add(fetchedItem);
      if (fetchedItem.found == 1) {
        _foundItemsArray.add(fetchedItem);
      } else {
        _lostItemsArray.add(fetchedItem);
      }
    }
    return _allItemsArray;
  }

  Future<List<Item>?> fetchFoundItems(String token, bool refresh) async {
    if (refresh || fetchingFromServerCount == 0) {
      var result = await fetchAllItems(token);
      if (result == null) {
        return null;
      }
    }
    return _foundItemsArray;
  }

  Future<List<Item>?> fetchLostItems(String token, bool refresh) async {
    if (refresh || fetchingFromServerCount == 0) {
      var result = await fetchAllItems(token);
      if (result == null) {
        return null;
      }
    }

    return _lostItemsArray;
  }

  Future<List<Item>?> filterItems(String token, bool foundOrLost,
      String category, String governorate, bool refresh) async {
    if (refresh) {
      var result = await fetchAllItems(token);
      if (result == null) {
        return null;
      }
    }
    if (foundOrLost) {
      return _foundItemsArray.where((element) {
        return (element.category == category &&
            element.governorate == governorate);
      }).toList();
    } else {
      return _lostItemsArray.where((element) {
        return (element.category == category &&
            element.governorate == governorate);
      }).toList();
    }
  }
}
