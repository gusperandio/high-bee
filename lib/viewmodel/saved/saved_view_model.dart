import 'package:flutter/material.dart';
import 'package:high_bee/infra/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';

class SavedViewModel extends ChangeNotifier {
  final Cache cache;
  bool isLoading = true;
  List<NewsModel> savedNews = [];

  SavedViewModel(this.cache);

  Future<void> loadSavedNews() async {
    isLoading = true;
    notifyListeners();
    savedNews = await cache.getListSavedNews();
    isLoading = false;
    notifyListeners();
  }
}
