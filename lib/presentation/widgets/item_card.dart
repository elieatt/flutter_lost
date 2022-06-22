import 'package:flutter/material.dart';

import '../../data/models/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
          child: Column(
        children: [
          FadeInImage(
              height: 300,
              fit: BoxFit.cover,
              placeholder: const AssetImage(
                "placeholderpng.png",
              ),
              image: NetworkImage(
                item.imageUrl,
              )),
          /* Image.network(
            item.image,
            filterQuality: FilterQuality.low,
            cacheWidth: 50,
            cacheHeight: 50,
          ) ,*/
          const SizedBox(
            height: 5,
          ),
          Text(item.title)
        ],
      )),
    ]);
  }
}
