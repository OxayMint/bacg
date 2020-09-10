import 'dart:convert';

import 'package:bacg/model/requests.dart' as request;
import 'package:bacg/model/responses.dart' as response;
import 'package:bacg/model/user.dart';
import 'package:bacg/services/local_data.service.dart';
import 'package:http/http.dart' as http;

final String urlBase = 'http://cx3crm.bestcreative.az/api/v1/';

String _getUrl(String path) {
  return urlBase + path;
}

String getToken() {
  return LocalData.getInstance.getToken();
}

void setToken(String t) {
  print('token is ' + t);
  return LocalData.getInstance.setToken(t);
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

Future<bool> register(request.Register req) async {
  final res = await http.post(
    _getUrl('register'),
    headers: getHeaders(),
    body: req.toMap(),
  );
  if (res.statusCode == 200) {
    return true;
  } else {
    print(res.body);
    return false;
  }
}

Future<bool> login(request.Login req) async {
  final res = await http.post(_getUrl('login'),
      headers: getHeaders(), body: req.toMap());
  if (res.statusCode == 200) {
    final token = json.decode(res.body)['meta']['token'];
    setToken(token);
    return true;
  } else {
    print(res.body);
    return false;
  }
}

Future<User> getUser() async {
  final res = await http.get(_getUrl('user'), headers: getHeaders());

  if (res.statusCode == 200) {
    return User.fromJson(res.body);
  } else if (res.statusCode == 401) {
    bool refreshed = await refresh();
    if (refreshed) {
      return getUser();
    } else {
      throw Exception('Failed to refresh');
    }
  } else {
    print(res.body);
    throw Exception('Failed to load user');
  }
}

Future<bool> refresh() async {
  final res = await http.post(_getUrl('refresh'), headers: getHeaders());
  if (res.statusCode == 200) {
    final token = json.decode(res.body)['token'];
    setToken(token);
    return true;
  } else {
    print('token refresh failed');
    return false;
  }
}

void getPackages(bool force) {
  http.get(_getUrl('packages'), headers: getHeaders());
}

void logOut() {
  http.post(_getUrl('logout'), headers: getHeaders());
  LocalData.getInstance.prefs.remove('token');
}
