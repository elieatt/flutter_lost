import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AuthMode { login, signup }
enum ConnectionType { wifi, mobile }
//
enum Category {
  money,
  idCard,
  wallet,
  personalItem,
  pet,
  documnets,
  computerDevice,
  phone,
  electronics,
  clothes,
  others
}
enum Governorate {
  homs,
  damascus,
  suwayda,
  lattakia,
  tartous,
  hama,
  idlib,
  deirEzZor,
  raqqa,
  alHasakah,
  qantira,
  daraa,
  aleppo
}

extension ParseCategoryToString on Category {
  String toShortString() {
    return toString().split('.').last;
  }

  IconData toIcon() {
    switch (this) {
      case Category.clothes:
        return FontAwesomeIcons.shirt;
      case Category.money:
        return FontAwesomeIcons.moneyBill;
      case Category.idCard:
        return FontAwesomeIcons.idCard;
      case Category.wallet:
        return FontAwesomeIcons.wallet;

      case Category.personalItem:
        return FontAwesomeIcons.spellCheck;

      case Category.pet:
        return FontAwesomeIcons.dog;

      case Category.documnets:
        return FontAwesomeIcons.file;

      case Category.computerDevice:
        return FontAwesomeIcons.computer;

      case Category.phone:
        return FontAwesomeIcons.phone;

      case Category.electronics:
        return FontAwesomeIcons.boltLightning;

      case Category.others:
        return FontAwesomeIcons.boltLightning;
    }
  }
}

extension ParseGovernorateToString on Governorate {
  String toShortString() {
    return toString().split('.').last;
  }
}
