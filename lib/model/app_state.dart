import 'dart:core';

import 'package:bacg/enums.dart';
import 'package:bacg/model/notification.dart';
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

  request.Register currentRegistration;
  String newPhoneNumber, registrationPhoneNumber;

  String loginException;
  Map<String, String> registerExceptions = {};
  CustomNotification message;
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
    if (LocalData.getInstance.registrationPhone != null) {
      loginStage = LoginStage.Otp;
    }
    ownedPackages = [];
    storePackages = [];
    registrationPhoneNumber =
        LocalData.getInstance.getPhone(OtpType.Registration);
    newPhoneNumber = LocalData.getInstance.getPhone(OtpType.Update);
    getStorePackages();
    if (token != '') {
      getUser();
    } else {
      loading = false;
    }
  }

  Future<void> login(request.Login request) async {
    var loginResult = await MainService.getInstance.login(request);
    if (loginResult.success) {
      user = loginResult.user;
      token = loginResult.token;
      LocalData.getInstance.setToken(token);
      getUserPackages();
    } else {
      print('Could not log in');
      loginException = loginResult.exception;
      setNotification(CustomNotification(
          text: loginResult.exception, type: NotificationType.Error));
    }
    notifyListeners();
  }

  void getUser() async {
    user = await MainService.getInstance.getUser();
    getUserPackages();
    notifyListeners();
  }

  void register(request.Register req) async {
    req = new request.Register(
        name: "aaad",
        surname: "soooyad",
        phone: "01234567897780",
        password: "qwerty");

    currentRegistration = req;
    var result = await MainService.getInstance.register(req);
    if (result.success) {
      LocalData.getInstance.setOtpPhone(req.phone, OtpType.Registration);
      setLoginStage(LoginStage.Otp);
    } else {
      registerExceptions = result.exceptions;
      loginException = registerExceptions[
          'password']; //.map((key, value) => value).toList();
      loginException =
          registerExceptions['phone']; //.map((key, value) => value).toList();
      // setNotification(CustomNotification(
      //     text: loginException, type: NotificationType.Error));
    }
    setNotification(CustomNotification(
        text: result.success ? 'SMS Code sent' : loginException,
        type:
            result.success ? NotificationType.Succes : NotificationType.Error));

    notifyListeners();
  }

  Future<bool> verifyOtp(String code, OtpType type) async {
    final success = await MainService.getInstance.verifyOtp(
      request.Verify(
        code: code,
        phone: LocalData.getInstance.getPhone(type),
      ),
      type,
    );
    var successMesage;
    if (success) {
      if (type == OtpType.Registration) {
        if (currentRegistration != null) {
          login(request.Login(
              phone: currentRegistration.phone,
              password: currentRegistration.password));
        }
        loginStage = LoginStage.SignIn;
        currentRegistration = null;
        successMesage = 'Registration complete';
      } else {
        print('Phone changed');
        getUser();
        successMesage = 'Phone number updated';
      }

      // LocalData.getInstance.removeOtp(type);
      removeOtp(type);
    }

    setNotification(
      CustomNotification(
          text: success ? successMesage : 'Wrong verification code',
          type: success ? NotificationType.Succes : NotificationType.Error),
    );

    notifyListeners();
    return success;
  }

  Future<bool> resendCode(OtpType type) async {
    var success = await MainService.getInstance
        .resendCode(LocalData.getInstance.getPhone(type), type);

    setNotification(
      CustomNotification(
          text: success ? 'Verification code was sent' : 'Some error happened',
          type: success ? NotificationType.Succes : NotificationType.Error),
    );
    return success;
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
    ownedPackages = [];
    LocalData.getInstance.setToken(null);
    notifyListeners();
  }

  void setLoginStage(LoginStage stage) {
    loginStage = stage;
    notifyListeners();
  }

  void setLang(String l) {
    Localization.getInstance.setLocale(l);
    LocalData.getInstance.setLang(l);
    notifyListeners();
  }

  void anonimousLogin() {
    final anonymUser = User(
        id: 0,
        name: 'Anonym',
        surname: '',
        userPackages: [],
        phone: '',
        anonymous: true);
    user = anonymUser;
    notifyListeners();
  }

  bool get isAnonymous {
    return user == null ? true : user.anonymous;
  }

  void setNotification(CustomNotification msg) {
    message = msg;
    notifyListeners();
    Future.delayed(Duration(seconds: 3)).then((value) {
      message = null;
      notifyListeners();
    });
  }

  Future<bool> updatePhone(String phone) async {
    var success = await resendCode(OtpType.Update);
    // var success = await MainService.getInstance.resendCode(
    //     phone, OtpType.Update); // LocalData.getInstance.updatingPhone = phone;
    if (success) {
      newPhoneNumber = phone;
      LocalData.getInstance.setOtpPhone(phone, OtpType.Update);
      notifyListeners();
    }
    return success;
  }

  void removeOtp(OtpType type) {
    LocalData.getInstance.removeOtp(type);
    if (type == OtpType.Registration) {
      registrationPhoneNumber = null;
    } else {
      newPhoneNumber = null;
    }
    notifyListeners();
  }

  void updatePassword(String oldPass, String newPass) async {
    final success =
        await MainService.getInstance.updatePassword(oldPass, newPass);
    if (success) {
      print('password updated');
    }
  }
}

enum LoginStage { Lang, SignIn, SignUp, Otp }
