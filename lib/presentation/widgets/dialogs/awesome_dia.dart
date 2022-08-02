import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';

AwesomeDialog buildAwrsomeDia(
    BuildContext context, String title, String message, String action,
    {DialogType? type}) {
  return AwesomeDialog(
      btnOkColor: Theme.of(context).colorScheme.secondary,
      aligment: Alignment.center,
      //width: 400.0,
      context: context,
      title: title,
      body: Center(
          child: Text(message,
              style: const TextStyle(fontStyle: FontStyle.italic))),
      dialogType: type ?? DialogType.INFO,
      btnOkText: action,
      btnOkOnPress: () {},
      animType: AnimType.SCALE);
}
