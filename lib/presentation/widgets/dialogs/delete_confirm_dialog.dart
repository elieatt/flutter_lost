import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmDialog<bool>(
    BuildContext context, String objectName, String? dialogMessage) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text("Are you sure?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).colorScheme.secondary),
                )),
            content: Text(
              dialogMessage ?? "Deleted $objectName can't be resotred",
              // style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          ),
        );
      });
}
