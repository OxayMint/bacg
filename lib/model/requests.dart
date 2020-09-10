class Register {
  String name;
  String surname;
  String password;
  String phone;

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
