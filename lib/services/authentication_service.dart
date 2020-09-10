import 'dart:convert';

import 'package:bacg/model/user.dart';

import 'package:bacg/model/requests.dart' as request;
import 'package:bacg/model/responses.dart' as response;
import '../exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import 'base_service.dart';
import 'local_data.service.dart';

// import '../mode/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<void> registerUser(request.Register req);
  Future<User> signInUsingPhoneAndPassword(request.Login req);
  Future<void> signOut();
}

class AuthService extends AuthenticationService {
  @override
  Future<User> getCurrentUser() async {
    final res = await http.get(MainService.getInstance.getUrl('user'),
        headers: MainService.getInstance.getHeaders());
    if (res.statusCode == 200) {
      return User.fromJson(res.body);
    } else {
      print(res.body);
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> signInUsingPhoneAndPassword(request.Login req) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await http.post(MainService.getInstance.getUrl('logout'),
        headers: MainService.getInstance.getHeaders());
    LocalData.getInstance.prefs.remove('token');
  }

  Future<bool> login(request.Login req) async {
    final res = await http.post(MainService.getInstance.getUrl('login'),
        headers: MainService.getInstance.getHeaders(), body: req.toMap());
    if (res.statusCode == 200) {
      final token = json.decode(res.body)['meta']['token'];
      setToken(token);
      return true;
    } else {
      print(res.body);
      return false;
    }
  }

  String getToken() {
    return LocalData.getInstance.getToken();
  }

  void setToken(String t) {
    print('token is ' + t);
    return LocalData.getInstance.setToken(t);
  }

  @override
  Future<bool> registerUser(request.Register req) async {
    final res = await http.post(
      MainService.getInstance.getUrl('register'),
      headers: MainService.getInstance.getHeaders(),
      body: req.toMap(),
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      print(res.body);
      return false;
    }
  }
}
