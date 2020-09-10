import 'dart:convert';

import 'package:bacg/model/pack.dart';

class User {
  User({this.id, this.name, this.phone, this.surname, this.userPackages});
  int id;
  String name;
  String surname;
  String phone;
  // String email;
  List<UserPackage> userPackages;
  factory User.fromJson(String jsonString) {
    final _map = json.decode(jsonString);
    var _userpacks = _map['user_packages'] as List;
    return User(
      id: _map['id'],
      name: _map['name'],
      surname: _map['surname'],
      phone: _map['phone'],
      userPackages: _userpacks.map((e) => UserPackage.fromJson(e)).toList(),
    );
  }
}

class UserPackage {
  int packageId;
  int callCount;
  DateTime endAt;
  Pack pack;
  int daysLeft;

  UserPackage({this.packageId, this.callCount, this.endAt, this.pack}) {
    daysLeft = DateTime.now().difference(this.endAt).inDays;
  }

  void initState() {}

  factory UserPackage.fromJson(Map<String, dynamic> jsonString) {
    return UserPackage(
        packageId: jsonString['package_id'],
        callCount: jsonString['call_count'],
        endAt: DateTime(jsonString['end_at'] as int),
        pack: Pack.fromJson(jsonString['package']));
  }
}

//  "id": 73,
//     "name": "Farhad",
//     "surname": "Goja",
//     "phone": "994515224452",
//     "email": null,
//     "verification_code": 68970,
//     "user_packages": []
