import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/services/news/news_service.dart';

class HomeViewModel extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<NewsModel> news = [];
  bool isLoading = false;
  bool isEmpty = true;
  String? myBackground;
  void _setLoadingState(bool state) {
    if (!hasListeners) return;
    isLoading = state;
    notifyListeners();
  }

  Future<void> fetchNews() async {
    _setLoadingState(true);
    try {
      final result = await _newsService.fetchAllNews();
      news = result ?? [];
      myBackground =
          news.isNotEmpty ? news[0].cape : "assets/images/Screenshot_3.png";
      isLoading = false;
      isEmpty = news.isEmpty;
    } catch (e) {
      isEmpty = true;
    } finally {
      _setLoadingState(false);
    }
  }
}
