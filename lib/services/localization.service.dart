import 'dart:convert';

import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/services.dart';

class Localized {
  final String key;
  Localized(this.key);
  String get value => Localization.getInstance.values[key].toString();
}

class Localization {
  static Localization _instance;
  Localization._();
  static Localization get getInstance =>
      _instance = _instance ?? Localization._();

  setLocale(String lang) async {
    final jsonString = await rootBundle.loadString("assets/langs.json");
    var map = json.decode(jsonString) as Map<String, dynamic>;
    values = map[lang]; //.toMap<String, String>(); // as Map<String, String>;
    // print(langVals);
  }

  Map<String, dynamic> values;
}
