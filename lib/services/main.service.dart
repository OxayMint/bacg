import 'dart:convert';

import 'package:bacg/enums.dart';
import 'package:bacg/model/pack.dart';
import 'package:bacg/model/phone_number.dart';
import 'package:bacg/model/requests.dart' as request;
import 'package:bacg/model/responses.dart' as response;
import 'package:bacg/model/user.dart';
// import 'package:bacg/model/user.dart';
// import 'package:bacg/services/authentication_service.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:http/http.dart' as http;

class MainService {
  static MainService _instance;

  MainService._();

  static MainService get getInstance =>
      _instance = _instance ?? MainService._();

  final String urlBase = 'https://cx3crm.bestcreative.az/api/v1/';
  String getUrl(String path) {
    return urlBase + path;
  }

  Map<String, String> getHeaders() {
    var headersMap = {'Accept': 'application/json'};

    if (LocalData.getInstance.prefs != null) {
      headersMap['Authorization'] =
          'Bearer ' + LocalData.getInstance.getToken();
    }
    return headersMap;
  }

  Future<response.Login> login(request.Login req) async {
    final res = await http.post(
      getUrl('login'),
      headers: getHeaders(),
      body: {'phone': req.phone.fullNumber, 'password': req.password},
    );
    if (res.statusCode == 200) {
      final token = json.decode(res.body)['meta']['token'];
      final payload = token.split('.')[1];
      var normalized = base64Url.normalize(payload);
      var resp = utf8.decode(base64Url.decode(normalized));
      final user = json.decode(resp)['user'];
      return response.Login(
        token: token,
        user: User.fromJson(user),
        success: true,
      );
    } else {
      print(res.body);
      final exceptionMessage = json.decode(res.body)['message'];
      return response.Login(success: false, exception: exceptionMessage);
    }
  }

  Future<User> getUser() async {
    final result = await http.get(getUrl('user'), headers: getHeaders());
    if (result.statusCode == 200) {
      return User.fromJson(json.decode(result.body));
    } else {
      return null;
    }
  }

  Future<List<Pack>> getPackages() async {
    final result = await http.get(getUrl('packages'), headers: getHeaders());
    if (result.statusCode == 200) {
      final jsonList = json.decode(result.body) as List;
      var resList = jsonList.map<Pack>((e) => Pack.fromJson(e)).toList();
      return resList;
    } else {
      return [];
    }
  }

  Future<List<UserPackage>> getUserPackages() async {
    final result =
        await http.get(getUrl('user/packages'), headers: getHeaders());
    if (result.statusCode == 200) {
      final jsonList = json.decode(result.body) as List;
      return jsonList.map<UserPackage>((e) => UserPackage.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<response.Register> register(request.Register req, String phone) async {
    var requestMap = req.toMap();
    requestMap['phone'] = phone;
    final result = await http.post(getUrl('register'),
        headers: getHeaders(), body: requestMap);
    if (result.statusCode == 200) {
      return new response.Register(success: true);
    } else {
      var map = Map<String, List<dynamic>>.from(json.decode(result.body));
      Map<String, String> exceptions = {};
      map.forEach((key, value) {
        exceptions[key] = value[0];
      });
      return new response.Register(
        success: false,
        exceptions: exceptions,
      );
    }
  }

  Future<response.Response> verifyOtp(request.Verify req, OtpType type) async {
    final path = type == OtpType.Registration
        ? 'verify_register'
        : 'verify_update_phone';
    final result =
        await http.post(getUrl(path), headers: getHeaders(), body: req.toMap());

    return response.Response(
        success: result.statusCode == 200, msg: result.reasonPhrase);
  }

  Future<response.Response> resendCode(
    String phone,
    OtpType type,
  ) async {
    final path = type == OtpType.Registration
        ? 'resend_code_register'
        : 'resend_code_update_phone';
    final headers = getHeaders();
    var result =
        await http.post(getUrl(path), headers: headers, body: {'phone': phone});
    print(result);
    return response.Response(
        success: result.statusCode == 200, msg: result.reasonPhrase);
  }

  Future<response.Response> updatePassword(
      String oldPass, String newPass) async {
    var result = await http.post(
      getUrl('update_user_password'),
      headers: getHeaders(),
      body: {'old_password': oldPass, 'password': newPass},
    );
    return response.Response(
        success: result.statusCode == 200,
        msg: result.statusCode == 200
            ? 'Password was updated'
            : result.reasonPhrase);
  }
}
