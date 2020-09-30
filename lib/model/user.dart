import 'dart:convert';

import 'package:bacg/model/pack.dart';

class User {
  User(
      {this.id,
      this.name,
      this.phone,
      this.surname,
      this.userPackages,
      this.anonymous = false});
  int id;
  String name;
  String surname;
  String phone;
  bool anonymous;
  List<UserPackage> userPackages;
  factory User.fromJson(Map<String, dynamic> _map) {
    // final _map = json.decode(jsonString);
    // var _userpacks = _map['user_packages'] as List;
    return User(
      id: _map['id'],
      name: _map['name'],
      surname: _map['surname'],
      phone: _map['phone'],
      // userPackages: _userpacks.map((e) => UserPackage.fromJson(e)).toList(),
    );
  }
}

class UserPackage {
  int packageId;
  int callCount;
  DateTime endAt;
  Pack pack;
  int daysLeft;
  bool expired;

  UserPackage({this.packageId, this.callCount, this.endAt, this.pack}) {
    print(this.endAt);
    daysLeft = this.endAt.difference(DateTime.now()).inDays;
    expired = daysLeft < 0;
  }

  factory UserPackage.fromJson(Map<String, dynamic> jsonMap) {
    return UserPackage(
        packageId: jsonMap['package_id'],
        callCount: jsonMap['call_count'],
        endAt: DateTime.fromMillisecondsSinceEpoch(jsonMap['end_at'] * 1000),
        pack: Pack.fromJson(jsonMap['package']));
  }
}

// class PhoneNumber {
//   final String dialCode;
//   final String number;
//   PhoneNumber({this.dialCode, this.number});
//   factory PhoneNumber.fromJson(Map<String, dynamic> jsonMap) {
//     return PhoneNumber(
//       dialCode: jsonMap['dial_code'],
//       number: jsonMap['number'],
//     );
//   }
// }
