// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:lostsapp/constants/list_of_classification.dart';

class FilterCategory extends StatefulWidget {
  final Function categorySetter;

  const FilterCategory({
    Key? key,
    required this.categorySetter,
  }) : super(key: key);

  @override
  State<FilterCategory> createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  String? _category;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: category.map(
        (e) {
          return RadioListTile<String>(
            secondary:
                Icon(toIcon(e), color: Theme.of(context).colorScheme.secondary),
            title: Text(e),
            toggleable: true,
            value: e,
            groupValue: _category,
            onChanged: (value) {
              if (value != null) {
                setState(
                  () {
                    _category = value;
                  },
                );
                widget.categorySetter(value);
              }
            },
          );
        },
      ).toList(),
    );
  }
}
