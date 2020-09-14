import 'package:flutter/material.dart';

import 'user.dart';

abstract class Result {
  final bool success;
  Result({@required this.success});
}

class Login extends Result {
  final String token;
  final User user;

  String exception;
  Login({@required this.token, @required this.user, @required success})
      : super(success: success);
}

class Register {}
