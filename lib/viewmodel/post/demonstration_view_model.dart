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
    const maxLength = 400;
    argument = argument
        .replaceAll('\r\n', '\n')
        .replaceAll('<paragrafo>', '\n\n');

    paragraphs =
        argument
            .split(RegExp(r'\n\s*\n'))
            .expand((p) => _splitLongParagraph(p.trim(), maxLength))
            .toList();
  }

  List<String> _splitLongParagraph(String paragraph, int maxLength) {
    if (paragraph.length <= maxLength) return [paragraph];

    List<String> parts = [];
    var sentences = paragraph.split(
      RegExp(r'(?<=[.!?]) '),
    ); // Divide por frases

    String current = '';
    for (var sentence in sentences) {
      if ((current + sentence).length > maxLength) {
        parts.add(current.trim());
        current = sentence;
      } else {
        current += '$sentence ';
      }
    }
    if (current.isNotEmpty) parts.add(current.trim());

    return parts;
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
      newsDatas.user!.createdAt = userDatas.createdAt!;
      newsDatas.cape = urls[0];
      newsDatas.createdAt = DateTime.now().toIso8601String();

      if (urls.length > 1) {
        newsDatas.photo1 = urls[1];
      }

      newsDatas.minReads = calcMinsRead(newsDatas.argument!);
      await newsService.createNews(newsDatas, newsDatas.user!.userId);

      await cache.remove('post');
      isValid = true;
    } catch (e) {
      errorMessage = "Erro inesperado, tente novamente mais tarde!";
    } finally {
      _setLoadingState(false);
    }
  }

  int calcMinsRead(String content) {
    const int wordsPerMinute = 250;
    final int textLength = content.split(" ").length;
    return (textLength / wordsPerMinute).ceil();
  }
}
