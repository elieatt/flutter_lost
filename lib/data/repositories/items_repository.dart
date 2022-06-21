import 'dart:convert';

import '../models/item.dart';
import '../network_services/items_netwroks_service.dart';

class ItemsRepository {
  final ItemsNetworkService service;

  ItemsRepository(this.service);
  Future<List<Item>> fetchItems() async {
    final String itemsRaw = await service.fetchItems();
    final Map<String, dynamic> decodedResponse = jsonDecode(itemsRaw);
    //print(decodedResponse["items"]);
    List<dynamic> items = decodedResponse["items"];
    //print(items);
    List<Item> itemsArray = [];
    items.forEach((element) {
      Item fetchedItem = Item.fromDynamic(element);
      itemsArray.add(fetchedItem);
    });
    return itemsArray;
  }
}
