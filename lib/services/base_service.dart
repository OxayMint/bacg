import 'dart:convert';

// import 'package:bacg/model/requests.dart' as request;
// import 'package:bacg/model/responses.dart' as response;
// import 'package:bacg/model/user.dart';
import 'package:bacg/services/authentication_service.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:http/http.dart' as http;

class MainService {
  static MainService _instance;

  MainService._();

  static MainService get getInstance =>
      _instance = _instance ?? MainService._();

  final String urlBase = 'http://cx3crm.bestcreative.az/api/v1/';
  String getUrl(String path) {
    return urlBase + path;
  }

  Map<String, String> getHeaders() {
    if (LocalData.getInstance.prefs == null) {
      return {'Accept': 'application/json'};
    }
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + getToken(),
    };
  }

  void getPackages(bool force) {
    http.get(getUrl('packages'), headers: getHeaders());
  }

  String getToken() {
    return LocalData.getInstance.getToken();
  }

  void setToken(String t) {
    print('token is ' + t);
    return LocalData.getInstance.setToken(t);
  }
}
