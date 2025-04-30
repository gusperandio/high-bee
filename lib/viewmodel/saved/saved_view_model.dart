import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';

class SavedViewModel extends ChangeNotifier {
  final Cache cache;

  SavedViewModel(this.cache) {
    isLoading = true;
    notifyListeners();
    loadSavedNews();
  }

  bool isLoading = true;
  List<NewsModel> savedNews = [];

  Future<void> loadSavedNews() async {
    savedNews = await cache.getListSavedNews();
    isLoading = false;
    notifyListeners();
  }
}
