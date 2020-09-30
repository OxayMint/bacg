import 'package:flutter/material.dart';

import 'user.dart';

class Response {
  final bool success;
  String msg;
  Response({@required this.success, this.msg});
}

class Login extends Response {
  String token;
  User user;

  String exception;
  Login({@required success, this.user, this.token, this.exception})
      : super(success: success);
}

class Register extends Response {
  Map<String, String> exceptions;
  Register({@required success, this.exceptions}) : super(success: success);
}
