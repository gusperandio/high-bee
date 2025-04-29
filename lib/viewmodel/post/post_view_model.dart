import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/cache.dart';

class PostViewModel extends ChangeNotifier {
  final cache = Cache();
  final formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [TextEditingController()];
  TextEditingController controllerTextReady = TextEditingController();
  final ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isValid = false;
  int linhas = 1;
  final int maxNumCharacters = 6000;

  int maxParagraph = 5;
  int _numParagraph = 0;
  int get numParagraph => _numParagraph;
  void setCurrentIndex(int value) {
    _numParagraph = value;
    notifyListeners();
  }

  int _numCharacters = 0;
  int get numCharacters => _numCharacters;
  void setNumCharacters(int value) {
    _numCharacters = value;
    setProgress(value);
    notifyListeners();
  }

  String _font = "Georgia";
  String get font => _font;
  void setFont(String value) {
    _font = value;
    notifyListeners();
  }

  double _progress = 0;
  double get progress => _progress;
  void setProgress(int value) {
    if (value >= maxNumCharacters) {
      _progress = 1.0;
    }
    _progress = value / maxNumCharacters;
  }

  NewsModel? _news;
  NewsModel? get news => _news;
  void setNews(NewsModel? value) {
    if (value == null) return;
    _news = value;
    notifyListeners();
  }

  PostViewModel() {
    initialize();
  }

  void adicionarParagrafo() {
    final textoAtual = controllerTextReady.text;

    final novoTexto = textoAtual.isEmpty ? '\n' : '$textoAtual\n<paragrafo>';

    controllerTextReady.text = novoTexto;
    atualizarLinhasDoParagrafo(
      controllerTextReady.text.trim().split(RegExp(r'\s+')).length,
    );
    notifyListeners();
  }

  void limpar() async {
    controllerTextReady.text = "";
    atualizarLinhasDoParagrafo(
      controllerTextReady.text.trim().split(RegExp(r'\s+')).length,
    );
    setNumCharacters(0);
    await cache.remove("post");
    notifyListeners();
  }

  void atualizarLinhasDoParagrafo(int quantidadePalavras) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controllerTextReady.selection = TextSelection.fromPosition(
        TextPosition(offset: controllerTextReady.text.length),
      );

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    if (quantidadePalavras == 0 && linhas != 1) {
      linhas = 1;
      notifyListeners();
      return;
    }

    int linhasCalculadas = (quantidadePalavras / 5).ceil();
    linhasCalculadas = linhasCalculadas.clamp(4, 9);

    linhas = linhasCalculadas;
    notifyListeners();
  }

  void colarTexto(bool isReady, {int nPr = 0}) async {
    final data = await Clipboard.getData('text/plain');
    if (data == null || data.text == null || data.text!.isEmpty) return;

    if (isReady) {
      controllerTextReady.text = data.text!;
      atualizarLinhasDoParagrafo(
        controllerTextReady.text.trim().split(RegExp(r'\s+')).length,
      );
      setNumCharacters(controllerTextReady.text.length);
    }

    notifyListeners();
  }

  Future<void> initialize() async {
    setNews(await cache.getNews());
    if (news == null) return;

    controllerTextReady.text = news!.argument!;
    _font = news!.font;
    setNumCharacters(controllerTextReady.text.length);

    atualizarLinhasDoParagrafo(numCharacters);
  }

  Future<void> saveContent() async {
    if (!formKey.currentState!.validate()) return;
    final newsCache = await cache.getNews();

    if (newsCache != null) {
      newsCache.argument = controllerTextReady.text;
      newsCache.font = font;
      await cache.setNews(newsCache);
      isValid = true;
      notifyListeners();
      return;
    }

    NewsModel myPost = NewsModel(
      argument: controllerTextReady.text,
      font: font,
    );
    await cache.setNews(myPost);
    isValid = true;
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
