import 'package:bacg/model/phone_number.dart';

class Register {
  final String name;
  final String surname;
  final String password;
  final String phone;
  Register({this.name, this.surname, this.phone, this.password});
  Map<String, String> toMap() {
    return {
      'name': name,
      'surname': surname,
      'password': password,
      'phone': phone
    };
  }

  factory Register.fromJson(Map<String, dynamic> _map) {
    return Register(
      name: _map['name'],
      surname: _map['surname'],
      phone: _map['phone'],
      password: _map['password'],
    );
  }
}

class Login {
  final PhoneNumber phone;
  final String password;
  Login({
    this.phone,
    this.password,
  });
  Map<String, dynamic> toMap() {
    return {'phone': phone.toMap(), 'password': password};
  }
}

class Verify {
  final String phone;
  final String code;

  Verify({this.phone, this.code});

  Map<String, String> toMap() {
    return {'phone': phone, 'verification_code': code};
  }
}
