import 'package:flutter/material.dart';

import 'user.dart';

abstract class Result {
  final bool success;

  Result({@required this.success});
}

class Login extends Result {
  String token;
  User user;

  String exception;
  Login({@required success, this.user, this.token, this.exception})
      : super(success: success);
}

class Register extends Result {
  Map<String, String> exceptions;
  Register({@required success, this.exceptions}) : super(success: success);
}
