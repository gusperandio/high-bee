import 'package:flutter/material.dart';
import 'package:high_bee/infra/models/datas/user.dart';
import 'package:high_bee/services/user/user_service.dart';
import 'package:high_bee/util/cache.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  final cache = Cache();
  UserModel user = UserModel();
  final String _name = "Gustavo Sperandio ";
  String get name => _name;
  int? _pubsNum;
  int? get pubsNum => _pubsNum;
  int? _stickersNum;
  int? get stickersNum => _stickersNum;
  int? _reportsNum;
  int? get reportsNum => _reportsNum;
  String? _seedTime;
  String? get seedTime => _seedTime;
  bool isLoading = true;

  Future<void> fetchUserDatas() async {
    final result = await _userService.getUserDatas();
    user = result ?? UserModel();

    _pubsNum = user.news != null ? user.news!.length : 0;
    _stickersNum = user.stickers != null ? user.stickers!.length : 0;
    _reportsNum = user.reports != null ? user.reports!.length : 0;
    _seedTime = user.createdAt ?? DateTime.now().toIso8601String();

    isLoading = false;
    notifyListeners();
  }
}
