import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static LocalData _instance;

  LocalData._();

  static LocalData get getInstance => _instance = _instance ?? LocalData._();
  SharedPreferences prefs;

  String token = '', lang = '';

  Future<void> init() async {
    final sharedPrefsInst = await SharedPreferences.getInstance();
    prefs = sharedPrefsInst;
    token = prefs.containsKey('token') ? prefs.getString('token') : '';
    lang = prefs.containsKey('lang') ? prefs.getString('lang') : '';
  }

  setToken(String token) {
    prefs.setString('token', token);
  }

  String getToken() {
    return token.isNotEmpty
        ? token
        : prefs.containsKey('token')
            ? prefs.getString('token')
            : '';
  }

  setLang(String lang) {
    prefs.setString('lang', lang);
  }

  String getLang() {
    return lang.isNotEmpty
        ? lang
        : prefs.containsKey('lang')
            ? prefs.getString('lang')
            : '';
  }
}
