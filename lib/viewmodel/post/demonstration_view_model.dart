import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/services/news/news_service.dart';
import 'package:high_bee/util/cache.dart';
import 'package:high_bee/util/firebase_storage.dart';

class DemonstrationViewModel extends ChangeNotifier {
  final cache = Cache();
  List<String> paragraphs = [];
  bool isLoading = false;
  bool isDialogVisible = false;
  bool isValid = false;
  String? errorMessage;
  FirebaseStorageService storageService = FirebaseStorageService();
  NewsModel? _news;
  NewsModel? get news => _news;

  DemonstrationViewModel() {
    loadNews();
  }

  Future<void> loadNews() async {
    try {
      _setLoadingState(true);
      final cachedNews = await cache.getNews();
      if (cachedNews != null) {
        _news = cachedNews;
        _splitParagraphs(cachedNews.argument ?? '');
      } else {
        errorMessage = "Nenhuma notícia encontrada no cache.";
      }
    } catch (e) {
      errorMessage = "Erro ao carregar dados.";
    } finally {
      _setLoadingState(false);
    }
  }

  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  void _splitParagraphs(String argument) {
   
    if (argument.contains('<paragrafo>')) {
      paragraphs = argument.split('<paragrafo>').map((e) => e.trim()).toList();
    } else { 
      paragraphs =
          argument.split(RegExp(r'\n\s*\n')).map((e) => e.trim()).toList();
    }
  }

  void saveMyNews() async {
    _setLoadingState(true);

    try {
      NewsModel newsDatas = news!;

      List<File> imagens =
          newsDatas.photo1 != null
              ? [File(newsDatas.cape!), File(newsDatas.photo1!)]
              : [File(newsDatas.cape!)];

      List<String> urls = await storageService.uploadImages(
        images: imagens,
        folderName: "news",
      );

      final userDatas = await cache.getUser();
      final newsService = NewsService();
      newsDatas.user!.userId = userDatas!.id!;
      newsDatas.user!.name = userDatas.name!;
      newsDatas.user!.intention = userDatas.intention!;

      newsDatas.cape = urls[0];
      if (urls.length > 1) {
        newsDatas.photo1 = urls[1];
      }

      await newsService.createNews(newsDatas, newsDatas.user!.userId);

      await cache.remove('post');
      isValid = true;
    } catch (e) {
      errorMessage = "Erro inesperado, tente novamente mais tarde!";
    } finally {
      _setLoadingState(false);
    }
  }
}
