import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  final String status;

  StatusTag(this.status);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
