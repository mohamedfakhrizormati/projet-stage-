import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class L10n {
  static const all = [
    Locale('fr'),
    Locale('en'),
  ];

  static Widget getFlag(String code) {
    return CountryFlag.fromCountryCode(
      code.toUpperCase(), // The package expects uppercase country codes
      height: 30,
      width: 50,
    );
  }
}
