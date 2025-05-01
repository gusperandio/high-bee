import 'dart:convert';

import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/models/datas/strain.dart';
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

  Future<void> setNews(NewsModel news) async {
    final newsJson = jsonEncode(news.toJson());
    await _prefs?.setString('post', newsJson);
  }

  Future<NewsModel?> getNews() async {
    final newsJson = _prefs?.getString('post');
    if (newsJson == null) return null;

    final newsMap = jsonDecode(newsJson);
    return NewsModel.fromJson(newsMap);
  }

  Future<void> setListNews(List<NewsModel> news) async {
    final newsJson = jsonEncode(news.map((e) => e.toJson()).toList());
    await _prefs?.setString('news', newsJson);
  }

  Future<List<NewsModel>?> getListNews() async {
    final newsJson = _prefs?.getString('news');
    if (newsJson == null) return null;

    final newsMap = jsonDecode(newsJson);
    return (newsMap as List).map((e) => NewsModel.fromJson(e)).toList();
  }

  Future<void> setListStrain(List<StrainModel> strain) async {
    final strainJson = jsonEncode(strain.map((e) => e.toJson()).toList());
    await _prefs?.setString('strains', strainJson);
  }

  Future<List<StrainModel>> getListStrains() async {
    final strainJson = _prefs?.getString('strains');
   if (strainJson == null) return [];

    final newsMap = jsonDecode(strainJson);
    return (newsMap as List).map((e) => StrainModel.fromJson(e)).toList();
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

  Future<void> setListSavedNews(NewsModel news) async {
    List<NewsModel> saved = await getListSavedNews();
    if (!saved.any((item) => item.id == news.id)) {
      saved.add(news);
    }

    final newsJson = jsonEncode(saved.map((e) => e.toJson()).toList());
    await _prefs?.setString('saved', newsJson);
  }

  Future<List<NewsModel>> getListSavedNews() async {
    final newsJson = _prefs?.getString('saved');
    if (newsJson == null) return [];

    final List<dynamic> decoded = jsonDecode(newsJson);
    return decoded.map((e) => NewsModel.fromJson(e)).toList();
  }

  Future<bool> isNewsSaved(String id) async {
    List<NewsModel> saved = await getListSavedNews();
    return saved.any((news) => news.id == id);
  }

  Future<void> removeNewsById(String id) async {
    List<NewsModel> saved = await getListSavedNews();
    saved.removeWhere((news) => news.id == id);

    final newsJson = jsonEncode(saved.map((e) => e.toJson()).toList());
    await _prefs?.setString('saved', newsJson);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }
}
