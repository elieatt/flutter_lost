import 'package:flutter/material.dart';

class UserNameTag extends StatelessWidget {
  final String name;
  MainAxisAlignment? alignment1;

  // ignore: use_key_in_widget_constructors
  UserNameTag({required this.name, this.alignment1});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: alignment1 ?? MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ]);
  }
}
