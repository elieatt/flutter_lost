import 'package:flutter/material.dart';

class ErrorSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double pageHeight = MediaQuery.of(context).size.height;
    return ListView(children: [
      SizedBox(
        height: pageHeight / 2,
      ),
      const Center(child: Text("error"))
    ]);
  }
}
