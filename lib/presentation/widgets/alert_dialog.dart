// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BuildAlrtDialog {
  static Widget dialog(
      BuildContext context, final String message, final String action) {
    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(action))
        ],
        content: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning),
              const SizedBox(
                height: 30.0,
              ),
              Text(message)
            ],
          ),
        ));
  }
}
