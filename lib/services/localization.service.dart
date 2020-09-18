import 'dart:convert';

import 'package:bacg/services/local_data.service.dart';
import 'package:flutter/services.dart';

class Localized {
  final String key;
  Localized(this.key);
  String get value => Localization.getInstance.getString(key);
}

class Localization {
  static Localization _instance;
  Localization._();
  static Localization get getInstance =>
      _instance = _instance ?? Localization._();

  String lang;
  init() async {
    // print(lang);
    lang = LocalData.getInstance.lang;
    Localization.getInstance.setLocale(lang);
    await setLocale(lang);
  }

  setLocale(String lang) async {
    final jsonString = await rootBundle.loadString("assets/langs.json");
    var map = json.decode(jsonString) as Map<String, dynamic>;
    values = map[lang]; //.toMap<String, String>(); // as Map<String, String>;
    // print(langVals);
  }

  String getString(String key) {
    return values == null ? '' : values[key].toString();
  }

  bool langSelected() {
    return lang != '';
  }

  setLang(String l) {
    lang = Localization.getInstance.setLocale(l);
    LocalData.getInstance.setLang(l);
    // notifyListeners();
  }

  Map<String, dynamic> values;
}
