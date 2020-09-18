import 'dart:core';

import 'package:bacg/model/pack.dart';
import 'package:bacg/model/user.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:bacg/services/main.service.dart';
import 'package:bacg/model/requests.dart' as request;

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool loading;
  // String lang;
  String token;
  User user;
  List<UserPackage> ownedPackages;
  List<Pack> storePackages;
  LoginStage loginStage;

  String loginException;
  Map<String, String> registerExceptions;
  AppState() {
    token = LocalData.getInstance.getToken();
    final lang = LocalData.getInstance.getLang();
    loading = true;
    // otpRefreshTime = LocalData.getInstance.

    //  DateTime.now().add(
    //   Duration(minutes: 3),
    // );

    // loginStage = LoginStage.Otp;
    loginStage = lang == '' ? LoginStage.Lang : LoginStage.SignIn;
    ownedPackages = [];
    storePackages = [];
    getStorePackages();
    if (token != '') {
      getUser();
    } else {
      loading = false;
    }
  }

  void login(request.Login request) async {
    var loginResult = await MainService.getInstance.login(request);
    if (loginResult.success) {
      user = loginResult.user;
      token = loginResult.token;
      LocalData.getInstance.setToken(token);
      getUserPackages();
    } else {
      print('Could not log in');
      loginException = loginResult.exception;
    }
    notifyListeners();
  }

  void getUser() async {
    user = await MainService.getInstance.getUser();
    getUserPackages();
    notifyListeners();
  }

  void register(request.Register req) async {
    var result = await MainService.getInstance.register(req);
    if (result.success) {
      setLoginStage(LoginStage.Otp);
    } else {
      registerExceptions = result.exceptions;
    }
    notifyListeners();
  }

  void resendCode() async {
    // var result = await MainSer
  }

  void getStorePackages() async {
    storePackages = await MainService.getInstance.getPackages();
    notifyListeners();
  }

  void getUserPackages() async {
    ownedPackages = await MainService.getInstance.getUserPackages();
    loading = false;
    notifyListeners();
  }

  void logout() {
    user = null;
    token = null;
    LocalData.getInstance.setToken(null);
    notifyListeners();
  }

  void setLoginStage(LoginStage stage) {
    loginStage = stage;
    notifyListeners();
  }

  void setLang(String l) {
    // lang = l;
    Localization.getInstance.setLocale(l);
    LocalData.getInstance.setLang(l);
    notifyListeners();
  }
}

enum LoginStage { Lang, SignIn, SignUp, Otp }
