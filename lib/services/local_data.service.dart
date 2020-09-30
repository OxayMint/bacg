import 'dart:convert';

import 'package:bacg/enums.dart';
import 'package:bacg/model/phone_number.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bacg/model/requests.dart' as request;

class LocalData {
  static LocalData _instance;
  LocalData._();
  static LocalData get getInstance => _instance = _instance ?? LocalData._();

  SharedPreferences prefs;

  String token = '', lang = '';
  PhoneNumber registrationPhone, updatingPhone;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    token = prefs.containsKey('token') ? prefs.getString('token') : '';
    lang = prefs.containsKey('lang') ? prefs.getString('lang') : '';
    registrationPhone = getPhone(OtpType.Registration);
    updatingPhone = getPhone(OtpType.Update);
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

  setOtpPhone(PhoneNumber phone, OtpType type) {
    if (type == OtpType.Registration) {
      registrationPhone = phone;
    } else {
      updatingPhone = phone;
    }
    resetOtpTime(type);
    prefs.setString(_getOtpPhoneKey(type), json.encode(phone.toMap()));
    // notify
  }

  removeOtp(OtpType type) {
    prefs.remove(_getOtpPhoneKey(type));
    prefs.remove(_getOtpTimeKey(type));
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

  PhoneNumber getPhone(OtpType type) {
    PhoneNumber phone;
    if (prefs.containsKey(_getOtpPhoneKey(type))) {
      phone = PhoneNumber.fromJson(
          json.decode(prefs.getString(_getOtpPhoneKey(type))));
    }
    return phone;
  }

  setRegistration(request.Register request) {
    prefs.setString("currentRegistration", json.encode(request.toMap()));
  }

  request.Register getRegistration() {
    request.Register registration;
    if (prefs.containsKey('currentRegistration')) {
      registration = request.Register.fromJson(
          json.decode(prefs.getString("currentRegistration")));
    }
    return registration;
  }

  removeRegistration() {
    prefs.remove('currentRegistration');
  }

  bool get rulesAccepted {
    return prefs.containsKey('rulesAccepted')
        ? prefs.getBool('rulesAccepted')
        : false;
  }

  acceptRules() {
    prefs.setBool('rulesAccepted', true);
  }
}
