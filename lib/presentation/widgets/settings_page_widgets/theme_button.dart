import 'package:flutter/material.dart';

import '../../../constants/themes.dart';

class ThemeButton extends StatelessWidget {
  final int index;
  final Function setColorIndex;

  const ThemeButton(
      {Key? key, required this.index, required this.setColorIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
          ),
        ),
        onPressed: () {
          setColorIndex(index);
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: mapIndexToColor(index)[0], shape: BoxShape.circle),
          child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  color: mapIndexToColor(index)[1],
                  shape: BoxShape.circle)),
        ),
      ),
    );
  }
}
