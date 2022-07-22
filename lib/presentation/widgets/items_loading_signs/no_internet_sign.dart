import 'package:flutter/material.dart';

class NoInternetSign extends StatelessWidget {
  final double pageHeight;

  const NoInternetSign({Key? key, required this.pageHeight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
        height: pageHeight / 3.5,
      ),
      Center(
        child: Icon(
          Icons.wifi_off_rounded,
          size: 50,
          color: Theme.of(context).accentColor,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Center(
        child: Text(
          "Check your internet connection and try again",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
