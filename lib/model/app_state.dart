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
  AppState() {
    lang = LocalData.getInstance.getLang();
    token = LocalData.getInstance.getToken();
    loading = true;
    ownedPackages = [];
    storePackages = [];
    getStorePackages();
    if (token != null) {
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
      notifyListeners();
    } else {
      print('Could not log in');
    }
  }

  void getUser() async {
    user = await MainService.getInstance.getUser();
    notifyListeners();
    getUserPackages();
  }

  void register() async {}

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
}
