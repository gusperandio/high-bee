import 'package:flutter/material.dart';
import 'package:high_bee/infra/models/datas/news.dart';
import 'package:high_bee/infra/models/datas/reports.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/services/reports/reports_service.dart';
import 'package:high_bee/util/cache.dart';

class NewsViewModel extends ChangeNotifier {
  final cache = Cache();
  List<String> paragraphs = [];
  int breakPoint = 0;
  bool isSaved = false;
  bool isReported = false;
  bool itsMeBaby = false;
  String? userId = AuthService().getCurrentUIDUser();
  final List<Map<String, String>> reports = [
    {
      "title": "Conteúdo promocional",
      "description":
          "A publicação promove ou incentiva o uso recreativo da cannabis, contrariando as diretrizes legais.",
    },
    {
      "title": "Venda de produtos",
      "description":
          "A publicação promove ou incentiva a compra de produtos sem autorização.",
    },
    {
      "title": "Promessa de cura",
      "description":
          "O conteúdo faz promessas de cura ou efeitos terapêuticos não comprovados cientificamente.",
    },
    {
      "title": "Informações sem embasamento",
      "description":
          "A publicação apresenta informações médicas ou científicas sem fonte confiável ou referência válida.",
    },
    {
      "title": "Linguagem inadequada",
      "description":
          "O conteúdo contém palavrões, termos ofensivos ou linguagem inadequada para o ambiente do app.",
    },
    {
      "title": "Comparações indevidas",
      "description":
          "A publicação compara produtos ou tratamentos com intuito promocional, sem evidência técnica.",
    },
    {
      "title": "Uso indevido de imagem",
      "description":
          "A publicação utiliza imagem de terceiros, marcas ou produtos sem autorização ou contexto adequado.",
    },
    {
      "title": "Spam ou conteúdo repetitivo",
      "description":
          "A publicação repete conteúdo com o intuito de ganhar visibilidade ou promover algo de forma excessiva.",
    },
    {
      "title": "Desinformação",
      "description":
          "O conteúdo pode induzir o leitor ao erro, disseminando mitos ou informações enganosas.",
    },
    {
      "title": "Conteúdo sensível ou ofensivo",
      "description":
          "A publicação aborda temas sensíveis de maneira desrespeitosa ou ofensiva.",
    },
    {
      "title": "Violação das RDCs",
      "description":
          "A publicação infringe diretamente as regras das RDCs 96/2008 ou 327/2019, como publicidade ou uso indevido de termos técnicos.",
    },
  ];

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

  Future<void> startReport(String reason, NewsModel newsReport) async {
    if (userId == newsReport.user!.userId) {
      itsMeBaby = true;
      notifyListeners();
      return;
    }

    isReported = true;
    notifyListeners();

    ReportModel report = ReportModel(
      newsId: newsReport.id!,
      userId: userId!,
      reason: reason,
      createdAt: DateTime.now().toIso8601String(),
    );
    await ReportsService().addReport(report);
  }
}
