import 'dart:convert';

import 'package:high_bee/models/datas/news.dart';
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

  Future<void> setNews(List<NewsModel> news) async {
    final newsJson = jsonEncode(news.map((e) => e.toJson()).toList());
    await _prefs?.setString('news', newsJson);
  }

  Future<NewsModel?> getNews() async {
    final newsJson = _prefs?.getString('news');
    if (newsJson == null) return null;

    final newsMap = jsonDecode(newsJson);
    return NewsModel.fromJson(newsMap);
  }

  Future<bool> getTrained() async {
    final trained = _prefs?.getBool('trained');
    if (trained == null) return false;
    return trained;
  }

  Future<void> setTrained() async {
    _prefs?.setBool('trained', true);
    return;
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
