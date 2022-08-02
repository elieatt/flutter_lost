import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class MessageText extends StatelessWidget {
  final double pageWidth;
  final String messagetxt;

  const MessageText(
      {Key? key, required this.pageWidth, required this.messagetxt})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: pageWidth - pageWidth / 5,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
            style: BorderStyle.values[1],
            color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ReadMoreText(
        messagetxt,
        style: const TextStyle(fontSize: 17),
        lessStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        trimLines: 10,
        colorClickableText: Colors.grey,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
