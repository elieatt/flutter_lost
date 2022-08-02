// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lostsapp/constants/list_of_classification.dart';

class LocationTag extends StatelessWidget {
  final String location;
  final String category;

  LocationTag(
    this.location,
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(4.0)),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(location),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "|",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  toIcon(category),
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(category),
              ],
            )),
      ],
    );
  }
}
