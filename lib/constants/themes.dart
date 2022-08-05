import 'package:flutter/material.dart';

List<ThemeData> themeArray = [
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
    ).copyWith(
      secondary: Colors.amber,
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
    ).copyWith(
      secondary: Colors.red,
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
      secondary: const Color.fromARGB(255, 228, 107, 255),
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.green,
    ).copyWith(
      secondary: const Color.fromRGBO(90, 150, 100, 1),
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey, brightness: Brightness.dark)
        .copyWith(
      secondary: const Color.fromARGB(255, 14, 148, 137),
    ),
  ),
];
List<Color> mapIndexToColor(index) {
  if (index == 0) {
    return [Colors.blueAccent, Colors.amber];
  } else if (index == 1) {
    return [Colors.redAccent, const Color.fromRGBO(255, 150, 140, 1)];
  } else if (index == 2) {
    return [Colors.purpleAccent, const Color.fromARGB(255, 228, 107, 255)];
  } else if (index == 3) {
    return [Colors.green, const Color.fromRGBO(90, 150, 100, 1)];
  }
  return [Colors.blueGrey, Color.fromARGB(255, 14, 148, 137)];
}
