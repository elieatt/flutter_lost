import 'dart:convert';

import '../models/item.dart';
import '../network_services/items_netwroks_service.dart';

class ItemsRepository {
  final ItemsNetworkService service;
  final List<Item> _allItemsArray = [];
  final List<Item> _foundItemsArray = [];
  final List<Item> _lostItemsArray = [];

  ItemsRepository(this.service);

  void clearArrays() {
    _allItemsArray.length = 0;
    _foundItemsArray.length = 0;
    _lostItemsArray.length = 0;
  }

  Future<List<Item>> fetchAllItems(String token) async {
    clearArrays();
    final String itemsRaw = await service.fetchItems(token);
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

  Future<List<Item>> fetchFoundItems(String token) async {
    await fetchAllItems(token);
    return _foundItemsArray;
  }

  Future<List<Item>> fetchLostItems(String token) async {
    await fetchAllItems(token);
    return _lostItemsArray;
  }
}
