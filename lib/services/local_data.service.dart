import 'package:bacg/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static LocalData _instance;
  LocalData._();
  static LocalData get getInstance => _instance = _instance ?? LocalData._();

  SharedPreferences prefs;

  String token = '', lang = '', registrationPhone, updatingPhone;
  Future<void> init() async {
    final sharedPrefsInst = await SharedPreferences.getInstance();
    prefs = sharedPrefsInst;
    token = prefs.containsKey('token') ? prefs.getString('token') : '';
    lang = prefs.containsKey('lang') ? prefs.getString('lang') : '';
    registrationPhone = prefs.containsKey(_getOtpPhoneKey(OtpType.Registration))
        ? prefs.getString(_getOtpPhoneKey(OtpType.Registration))
        : null;
    updatingPhone = prefs.containsKey(_getOtpPhoneKey(OtpType.Update))
        ? prefs.getString(_getOtpPhoneKey(OtpType.Update))
        : null;
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

  DateTime getOtpTime(OtpType type) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(0);
    if (prefs.containsKey(_getOtpTimeKey(type))) {
      time = DateTime.fromMillisecondsSinceEpoch(
          prefs.getInt(_getOtpTimeKey(type)));
    }
    return time;
  }

  resetOtpTime(OtpType type) {
    final time = DateTime.now().add(Duration(minutes: 3));
    final key = _getOtpTimeKey(type);
    prefs.setInt(key, time.millisecondsSinceEpoch);
  }

  setOtpPhone(String phone, OtpType type) {
    if (type == OtpType.Registration) {
      registrationPhone = phone;
    } else {
      updatingPhone = phone;
    }
    resetOtpTime(type);
    prefs.setString(_getOtpPhoneKey(type), phone);
  }

  removeOtp(OtpType type) {
    prefs.remove(_getOtpPhoneKey(type));
    prefs.remove(_getOtpTimeKey(type));
    if (type == OtpType.Registration) {
      registrationPhone = null;
    } else {
      updatingPhone = null;
    }
  }

  String _getOtpTimeKey(OtpType type) {
    return type == OtpType.Registration
        ? 'otpTime_$registrationPhone'
        : 'otpTime_$updatingPhone';
  }

  String _getOtpPhoneKey(OtpType type) {
    return type == OtpType.Registration ? 'regPhone' : 'updatingPhone';
  }

  String getPhone(OtpType type) {
    return type == OtpType.Registration ? registrationPhone : updatingPhone;
  }
}
