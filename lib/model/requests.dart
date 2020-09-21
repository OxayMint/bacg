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
}

class Login {
  final String phone;
  final String password;
  Login({
    this.phone,
    this.password,
  });
  Map<String, String> toMap() {
    return {'phone': phone, 'password': password};
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
