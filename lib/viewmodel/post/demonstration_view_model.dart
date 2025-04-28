import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';
import 'package:high_bee/util/firebase_storage.dart';

class DemonstrationViewModel extends ChangeNotifier {
  final storageService = FirebaseStorageService();
  final cache = Cache();
  File? selectedCape;
  File? selectedImage1;
  String? errorMessage;
  bool isDialogVisible = false;
  bool isLoading = false;
  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  late final Object arguments;

  void setArguments(Object args) {
    if (_argumentsWasSet) return;
    arguments = args;
    _argumentsWasSet = true;
  }

  bool _argumentsWasSet = false;

  NewsModel? _news;
  NewsModel? get news => _news;
  void setNews(NewsModel? value) {
    if (value == null) return;
    _news = value;
    notifyListeners();
  }

  DemonstrationViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    setNews(await cache.getNews());
  }

  void saveMyNews() {
    // _setLoadingState(true);

    // List<File> imagens =
    //     selectedImage1 != null
    //         ? [selectedCape!, selectedImage1!]
    //         : [selectedCape!];

    // List<String> urls = await storageService.uploadImages(
    //   images: imagens,
    //   folderName: pasta,
    // );

    //   final userService = AuthService().getCurrentUIDUser();
    //   final newsService = NewsService();

    // } catch (e) {
    //   _setErrorMessageState("Erro inesperado, tente novamente mais tarde!");
    // } finally {
    //   // _setLoadingState(false);
  }
}
