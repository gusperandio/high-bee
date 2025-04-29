import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/user/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  UserModel user = UserModel();
  final String _name = "Gustavo Sperandio ";
  String get name => _name;
  int? _pubsNum;
  int? get pubsNum => _pubsNum;
  int? _stickersNum;
  int? get stickersNum => _stickersNum;
  int? _reportsNum;
  int? get reportsNum => _reportsNum;
  bool isLoading = true;

  Future<void> fetchUserDatas() async {
    final result = await _userService.getUserDatas();
    user = result ?? UserModel();

    _pubsNum = user.news != null ? user.news!.length : 0;
    _stickersNum = user.stickers != null ? user.stickers!.length : 0;
    _reportsNum = user.reportNews != null ? user.reportNews!.length : 0;

    isLoading = false;
    notifyListeners();
  }
}
