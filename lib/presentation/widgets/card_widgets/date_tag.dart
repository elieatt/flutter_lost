import 'package:flutter/material.dart';

class DateTag extends StatelessWidget {
  final DateTime date;

  DateTag(this.date);

  @override
  Widget build(BuildContext context) {
    final double pageWidth = MediaQuery.of(context).size.width;
    return Container(
      width: pageWidth < 736 ? pageWidth - pageWidth / 3.5 : pageWidth / 2,
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(4.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.date_range,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                text: hour((date.hour)) +
                    ":" +
                    minute(date.minute) +
                    " ------------------ ",
              ),
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                text: dayOrDate(date),
              )
            ]),
          )
        ],
      ),
    );
  }

  String hour(int x) {
    if (x < 10) {
      return "AM " + "0" + x.toString();
    } else if (x >= 10 && x < 12) {
      return "AM " + x.toString();
    } else if (x == 12) {
      return "PM " + x.toString();
    }
    return "PM " + "0" + (x % 12).toString();
  }

  String minute(int x) {
    if (x < 10) {
      return "0" + x.toString();
    }
    return x.toString();
  }

  String dayOrDate(DateTime dt) {
    DateTime dtnow = DateTime.now();

    if ((dtnow.difference(dt)).inDays < 1) {
      return "TODAY!";
    } else if ((dtnow.difference(dt)).inDays >= 1 &&
        (dtnow.difference(dt)).inDays < 2) {
      return "YESTERDAY!";
    }
    return dt.day.toString() +
        "/" +
        dt.month.toString() +
        "/" +
        dt.year.toString();
  }
}
