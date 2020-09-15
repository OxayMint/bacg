import 'dart:convert';

import 'package:bacg/model/pack.dart';
import 'package:bacg/model/requests.dart' as request;
import 'package:bacg/model/responses.dart' as response;
import 'package:bacg/model/user.dart';
// import 'package:bacg/model/user.dart';
// import 'package:bacg/services/authentication_service.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
    if (LocalData.getInstance.prefs == null) {
      return {'Accept': 'application/json'};
    }
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + LocalData.getInstance.getToken(),
    };
  }

  Future<response.Login> login(request.Login req) async {
    final res = await http.post(
      getUrl('login'),
      headers: MainService.getInstance.getHeaders(),
      body: req.toMap(),
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
      return response.Login(success: false, token: null, user: null);
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
}