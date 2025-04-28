import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/news/news_service.dart';
import 'package:high_bee/services/user/user_service.dart';
import 'package:high_bee/util/avatar.dart';
import 'package:high_bee/util/cache.dart';

class LoadingViewModel extends ChangeNotifier {
  bool finished = false;
  bool started = true;

  void initPage() async {
    UserModel? user = await Cache().getUser();
    if (user != null) {
      user.avatar =
          user.avatar != '' ? user.avatar : AvatarUtil().getAvatarUrl();
      await UserService().saveUserRegistes(user);
    }
    getAllPosts();
  }

  void getAllPosts() async {
    List<NewsModel>? news = await NewsService().fetchAllNews();
    if (news != null) {
      await Cache().setListNews(news);
    }

    started = false;
    finished = true;
    notifyListeners();
  }
}
