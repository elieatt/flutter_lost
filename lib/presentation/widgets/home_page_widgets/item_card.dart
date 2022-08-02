import 'package:flutter/material.dart';
import 'package:lostsapp/presentation/widgets/global/item_image.dart';

import '../../../data/models/item.dart';

import '../card_widgets/date_tag.dart';
import '../card_widgets/location_and_category_tag.dart';

import '../card_widgets/status_tag.dart';
import '../card_widgets/title.dart';
import '../card_widgets/userName_tag.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard(this.item);

  Widget _buildTitleStatusRow() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Text(thing.title),
          FittedBox(child: TitleDefault(item.title)),
          const SizedBox(
            width: 8.0,
          ),
          StatusTag(item.found == 1 ? "FOUND" : "MISSING"),
          // Text(thing.description),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: const Icon(Icons.info),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              Navigator.of(context).pushNamed("/itemView", arguments: item);
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: UserNameTag(name: item.user["userName"]),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: InteractiveViewer(
                child: ItemImage(
                    boxFit: BoxFit.cover,
                    heroTag: item.id,
                    imageUrl: item.imageUrl,
                    imageHeight: 275),
              ),
            ),
            _buildTitleStatusRow(),
            const SizedBox(
              height: 5.0,
            ),
            Center(child: LocationTag(item.governorate, item.category)),
            const SizedBox(
              height: 10,
            ),
            DateTag(item.dateofloss),
            const SizedBox(
              height: 5,
            ),

            // Text(thing.userEmail),
            // Text(thing.description),
            _buildActionButtons(context),
            // Spacer(),
          ],
        ),
      ),
      const Divider(
        height: 30,
        indent: 45,
        endIndent: 45,
      )
    ]);
  }
}
