import 'dart:convert';

import 'package:high_bee/models/datas/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static final Cache _instance = Cache._internal();
  SharedPreferences? _prefs;

  factory Cache() {
    return _instance;
  }

  Cache._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
 
  bool? getAuth() {
    return _prefs?.getBool('AuthenticationState'); 
  }

  Future<void> setAuth(bool value) async {
    await _prefs?.setBool('AuthenticationState', value);
  }

  Future<void> setUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs?.setString('user', userJson);
  }

  Future<UserModel?> getUser() async {
    final userJson = _prefs?.getString('user');
    if (userJson == null) return null;

    final userMap = jsonDecode(userJson);
    return UserModel.fromJson(userMap);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
