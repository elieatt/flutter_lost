// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../../constants/list_of_classification.dart';

class FilterGovernorate extends StatefulWidget {
  final Function governorateSetter;
  const FilterGovernorate({
    Key? key,
    required this.governorateSetter,
  }) : super(key: key);

  @override
  State<FilterGovernorate> createState() => _FilterGovernorateState();
}

class _FilterGovernorateState extends State<FilterGovernorate> {
  String? _gover;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: governorate.map((e) {
        return RadioListTile<String>(
            title: Text(e),
            value: e,
            groupValue: _gover,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _gover = value;
                });
                widget.governorateSetter(value);
              }
            });
      }).toList(),
    );
  }
}
