import 'package:flutter/material.dart';

class ErrorSign extends StatelessWidget {
  const ErrorSign({Key? key}) : super(key: key);

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
