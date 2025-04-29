import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';
import 'package:high_bee/util/firebase_storage.dart';

class DemonstrationViewModel extends ChangeNotifier {
  final cache = Cache();
  NewsModel? _news;
  List<String> paragraphs = [];
  bool isLoading = true;
  bool isDialogVisible = false;
  String? errorMessage;

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
    // Primeiro, tentamos dividir pelo token <paragrafo>
    if (argument.contains('<paragrafo>')) {
      paragraphs = argument.split('<paragrafo>').map((e) => e.trim()).toList();
    } else {
      // Se não houver, tentamos quebrar pelo padrão de espaçamentos (dois \n seguidos)
      paragraphs =
          argument.split(RegExp(r'\n\s*\n')).map((e) => e.trim()).toList();
    }
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
