import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';

class NewsViewModel extends ChangeNotifier {
  final cache = Cache();
  List<String> paragraphs = [];
  int breakPoint = 0;
  bool isSaved = false;

  void initialize(NewsModel news) {
    splitParagraphs(news.argument!);
    myNewsIsSaved(news.id!);
  }

  void splitParagraphs(String argument) {
    const maxLength = 400;
    argument = argument
        .replaceAll('\r\n', '\n')
        .replaceAll('<paragrafo>', '\n\n');

    paragraphs =
        argument
            .split(RegExp(r'\n\s*\n'))
            .expand((p) => _splitLongParagraph(p.trim(), maxLength))
            .toList();

    breakPoint = (paragraphs.length / 2).ceil();
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

  Future<void> saveNews(NewsModel myNews) async {
    await cache.setListSavedNews(myNews);
    isSaved = true;
    notifyListeners();
  }

  Future<void> myNewsIsSaved(String id) async {
    isSaved = await cache.isNewsSaved(id);
    notifyListeners();
  }

  Future<void> removeNews(String id) async {
    await cache.removeNewsById(id);
    isSaved = false;
    notifyListeners();
  }
}
