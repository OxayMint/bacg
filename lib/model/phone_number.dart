import 'package:flutter/material.dart';

class PhoneNumber {
  final String dialCode;
  final String countryCode;
  final String number;
  PhoneNumber(
      {@required this.dialCode,
      @required this.countryCode,
      @required this.number});

  String get fullNumber {
    return dialCode.replaceAll('+', '') +
        number.replaceFirst(RegExp(r'^0'), '');
  }

  factory PhoneNumber.fromJson(Map<String, dynamic> _map) {
    // final _map = json.decode(jsonString);
    // var _userpacks = _map['user_packages'] as List;
    return PhoneNumber(
      dialCode: _map['dial_code'],
      countryCode: _map['country_code'],
      number: _map['number'],
    );
  }

  Map<String, String> toMap() {
    return {
      'dial_code': dialCode,
      'country_code': countryCode,
      'number': number,
    };
  }
}
