import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<String> category = [
  "Money",
  "ID card",
  "Wallet",
  "Personal item",
  "Pet",
  "Documnets",
  "Computer device",
  "Phone",
  "Electronics",
  "Clothes",
  "Others"
];
const List<String> governorate = [
  "Homs",
  "Damascus",
  "Suwayda",
  "Lattakia",
  "Tartous",
  "Hama",
  "Idlib",
  "DeirEzZor",
  "Raqqa",
  "AlHasakah",
  "Qantira",
  "Daraa",
  "Aleppo"
];
IconData toIcon(String str) {
  switch (str) {
    case "Clothes":
      return FontAwesomeIcons.shirt;
    case "Money":
      return FontAwesomeIcons.moneyBill;
    case "ID card":
      return FontAwesomeIcons.idCard;
    case "Wallet":
      return FontAwesomeIcons.wallet;

    case "Personal item":
      return FontAwesomeIcons.spellCheck;

    case "Pet":
      return FontAwesomeIcons.dog;

    case "Documents":
      return FontAwesomeIcons.file;

    case "Computer":
      return FontAwesomeIcons.computer;

    case "Phone":
      return FontAwesomeIcons.phone;

    case "Electronics":
      return FontAwesomeIcons.boltLightning;

    case "Others":
      return FontAwesomeIcons.boltLightning;
    default:
      return FontAwesomeIcons.boltLightning;
  }
}
