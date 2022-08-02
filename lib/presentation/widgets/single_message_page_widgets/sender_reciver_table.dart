import 'package:flutter/material.dart';

import '../card_widgets/userName_tag.dart';

class SenderReciverTable extends StatelessWidget {
  final double pageWidth;
  final String sender;
  final String reciver;

  const SenderReciverTable(
      {Key? key,
      required this.pageWidth,
      required this.sender,
      required this.reciver})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
      width: pageWidth > 720 ? pageWidth / 3.5 : pageWidth,
      child: Table(
        //border: TableBorder.all(),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Text(
                  "FROM :",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              UserNameTag(alignment1: MainAxisAlignment.start, name: sender),
            ],
          ),
          const TableRow(children: [
            SizedBox(height: 15), //SizeBox Widget
            SizedBox(height: 15),
          ]),
          TableRow(children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Text(
                "TO       :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            UserNameTag(alignment1: MainAxisAlignment.start, name: reciver)
          ])
        ],
      ),
    );
  }
}
