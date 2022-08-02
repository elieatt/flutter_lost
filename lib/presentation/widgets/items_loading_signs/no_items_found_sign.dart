import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoItemsFoundSign extends StatelessWidget {
  final double pageHeight;

  const NoItemsFoundSign({Key? key, required this.pageHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(height: pageHeight / 3),
      Center(
        child: FaIcon(
          FontAwesomeIcons.ban,
          size: 80,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Center(child: Text("NO ITEMS FOUND"))
    ]);
  }
}
