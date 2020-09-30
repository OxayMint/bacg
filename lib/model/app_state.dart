import 'dart:core';
import 'package:bacg/enums.dart';
import 'package:bacg/model/notification.dart';
import 'package:bacg/model/pack.dart';
import 'package:bacg/model/phone_number.dart';
import 'package:bacg/model/user.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:bacg/services/localization.service.dart';
import 'package:bacg/services/main.service.dart';
import 'package:bacg/model/requests.dart' as request;
import 'package:bacg/model/responses.dart' as response;

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
  PhoneNumber updatingPhone, registrationPhone;

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
    registrationPhone = LocalData.getInstance.getPhone(OtpType.Registration);
    updatingPhone = LocalData.getInstance.getPhone(OtpType.Update);
    currentRegistration = LocalData.getInstance.getRegistration();
    getStorePackages();
    if (token != '') {
      getUser();
    } else {
      loading = false;
    }
  }

  Future<void> login(request.Login request) async {
    response.Login loginResult;
    if (request.phone.number == '' || request.password == '') {
      setNotification(CustomNotification(
          text: 'Login and phone should not be empty',
          type: NotificationType.Error));
      return;
    }
    loginResult = await MainService.getInstance.login(request);
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

  void register(
      request.Register req, String confirmPass, PhoneNumber phone) async {
    // req = new request.Register(
    //     name: "aaad",
    //     surname: "soooyad",
    //     phone: "0515224452",
    //     password: "asdfghjkl");

    currentRegistration = req;
    registrationPhone = phone;
    response.Register result;
    if (req.name == '' ||
        req.password == '' ||
        req.phone == '' ||
        req.surname == '' ||
        confirmPass == '') {
      setNotification(CustomNotification(
          text: 'All fields should be filled', type: NotificationType.Error));
      return;
    }
    if (req.password != confirmPass) {
      setNotification(CustomNotification(
          text: 'Passwords don\'t match', type: NotificationType.Error));
      return;
    }
    // req.phone =
    result = await MainService.getInstance.register(req, phone.fullNumber);
    if (result.success) {
      LocalData.getInstance.setOtpPhone(phone, OtpType.Registration);
      LocalData.getInstance.setRegistration(req);
      setLoginStage(LoginStage.Otp);
    } else {
      registerExceptions = result.exceptions;
      loginException = registerExceptions['password'];
      loginException = registerExceptions['phone'];
    }
    setNotification(
      CustomNotification(
          text: result.success ? 'SMS Code sent' : loginException,
          type: result.success
              ? NotificationType.Succes
              : NotificationType.Error),
    );
  }

  Future<bool> verifyOtp(String code, OtpType type) async {
    final response = await MainService.getInstance.verifyOtp(
      request.Verify(
        code: code,
        phone: type == OtpType.Registration
            ? registrationPhone.fullNumber
            : updatingPhone.fullNumber,
      ),
      type,
    );
    var successMesage;

    if (response.success) {
      if (type == OtpType.Registration) {
        if (currentRegistration != null) {
          login(request.Login(
              phone: registrationPhone,
              password: currentRegistration.password));
        }
        loginStage = LoginStage.SignIn;
        currentRegistration = null;
        successMesage = 'Registration complete';
        LocalData.getInstance.removeRegistration();
      } else {
        getUser();
        successMesage = 'Phone number updated';
      }

      // LocalData.getInstance.removeOtp(type);
      removeOtp(type);
    }

    setNotification(
      CustomNotification(
          text: response.success
              ? successMesage
              : response.msg ?? 'Wrong verification code',
          type: response.success
              ? NotificationType.Succes
              : NotificationType.Error),
    );

    notifyListeners();
    return response.success;
  }

  Future<bool> resendCode(String phone, OtpType type) async {
    var response = await MainService.getInstance.resendCode(phone, type);

    setNotification(
      CustomNotification(
        text: response.success
            ? 'Verification code was sent'
            : 'Some error happened',
        type:
            response.success ? NotificationType.Succes : NotificationType.Error,
      ),
    );
    return response.success;
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

  Future<bool> updatePhone(PhoneNumber phone) async {
    var success = await resendCode(phone.fullNumber, OtpType.Update);
    if (success) {
      updatingPhone = phone;
      LocalData.getInstance.setOtpPhone(phone, OtpType.Update);
      // setCountryCode(countryCode, OtpType.Update);
      notifyListeners();
    }
    return success;
  }

  void removeOtp(OtpType type) {
    LocalData.getInstance.removeOtp(type);
    if (type == OtpType.Registration) {
      registrationPhone = null;
    } else {
      updatingPhone = null;
    }
    notifyListeners();
  }

  Future<bool> updatePassword(
      String oldPass, String newPass, String passConfirm) async {
    final passMatch = newPass == passConfirm;
    response.Response res;
    if (passMatch) {
      res = await MainService.getInstance.updatePassword(oldPass, newPass);
    } else {
      res = response.Response(success: false, msg: "Passwords don't match");
    }

    setNotification(CustomNotification.fromResponse(res));

    return res.success;
  }
}

enum LoginStage { Lang, SignIn, SignUp, Otp }
