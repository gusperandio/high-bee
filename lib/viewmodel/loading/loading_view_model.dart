import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/strain.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/strains/strain_service.dart';
import 'package:high_bee/services/user/user_service.dart';
import 'package:high_bee/util/avatar.dart';
import 'package:high_bee/util/cache.dart';

class LoadingViewModel extends ChangeNotifier {
  bool finished = false;
  bool started = true;

  void initPage() async {
    UserModel? user = await Cache().getUser();
    if (user != null) {
      user.avatar = AvatarUtil().getAvatarAsset();
      await UserService().saveUserRegistes(user);
      await Cache().setUser(user);
      await Cache().setListStrain(await StrainService().getAllStrains());
    }
    started = false;
    finished = true;
    notifyListeners();
  }
}
