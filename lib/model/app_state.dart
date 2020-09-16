import 'dart:core';

import 'package:bacg/model/pack.dart';
import 'package:bacg/model/user.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:bacg/services/main_service.dart';
import 'package:bacg/model/requests.dart' as request;

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool loading;
  String lang;
  String token;
  User user;
  List<UserPackage> ownedPackages;
  List<Pack> storePackages;
  LoginStage loginStage;
  DateTime otpRefreshTime;
  AppState() {
    lang = LocalData.getInstance.getLang();
    print(lang);
    token = LocalData.getInstance.getToken();
    loading = true;
    otpRefreshTime = DateTime.now().add(
      Duration(minutes: 3),
    );
    loginStage = LoginStage.Otp;
    //lang == '' ? LoginStage.Lang : LoginStage.SignIn;
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
      notifyListeners();
    } else {
      print('Could not log in');
    }
  }

  void getUser() async {
    user = await MainService.getInstance.getUser();
    getUserPackages();
    notifyListeners();
  }

  void register(request.Register req) async {
    var result = await MainService.getInstance.register(req);
    if (result) {
      otpRefreshTime = DateTime.now().add(
        Duration(minutes: 3),
      );
      setLoginStage(LoginStage.Otp);
    }
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
    lang = l;
    LocalData.getInstance.setLang(l);
    notifyListeners();
  }
}

enum LoginStage { Lang, SignIn, SignUp, Otp }
