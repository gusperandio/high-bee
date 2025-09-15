import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:high_bee/infra/models/datas/news.dart';

import 'package:high_bee/util/cache.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePostViewModel extends ChangeNotifier {
  final cache = Cache();
  File? selectedCape;
  File? selectedImage1;
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubtitleImg = TextEditingController();
  ValueNotifier<String?> tagNotifier = ValueNotifier(null);
  final List<Map<String, String>> tags = [
    {"name": "Cannabis"},
    {"name": "Maconha"},
    {"name": "Erva"},
    {"name": "Cultura canábica"},
    {"name": "História da Cannabis"},
    {"name": "Legalização"},
    {"name": "Proibição"},
    {"name": "Mercado canábico"},
    {"name": "Indústria da Cannabis"},
    {"name": "Política e Cannabis"},
    {"name": "Cannabis medicinal"},
    {"name": "Saúde com Cannabis"},
    {"name": "Benefícios da Cannabis"},
    {"name": "Tratamentos naturais"},
    {"name": "Fitoterapia"},
    {"name": "Ansiedade e Cannabis"},
    {"name": "Dor crônica e Cannabis"},
    {"name": "Sono e Cannabis"},
    {"name": "Qualidade de vida"},
    {"name": "Autocuidado"},
    {"name": "Uso recreativo"},
    {"name": "Experiências com Cannabis"},
    {"name": "Consumo consciente"},
    {"name": "Cultura 420"},
    {"name": "Estilo de vida canábico"},
    {"name": "Redução de danos"},
    {"name": "Viagens e Cannabis"},
    {"name": "Estudos científicos"},
    {"name": "Efeitos da Cannabis"},
    {"name": "Canabinoides"},
    {"name": "THC"},
    {"name": "CBD"},
    {"name": "Terpenos"},
    {"name": "Sistema Endocanabinoide"},
    {"name": "Notícias"},
    {"name": "Novas pesquisas"},
    {"name": "Atualizações legislativas"},
    {"name": "Mercado e tendências"},
    {"name": "Casos reais"},
    {"name": "Cultivo caseiro"},
    {"name": "Cultivo Indoor"},
    {"name": "Cultivo Outdoor"},
    {"name": "Práticas sustentáveis"},
    {"name": "Produtos canábicos"},
    {"name": "Cosméticos com Cannabis"},
    {"name": "Comida e Cannabis"},
    {"name": "Extrações e óleos"},
    {"name": "Ativismo canábico"},
    {"name": "Eventos e feiras"},
    {"name": "Influenciadores canábicos"},
  ];
  String? _tag;
  String? get tag => _tag;
  void setTag(String value) {
    _tag = value;
    tagNotifier.value = tag;
    notifyListeners();
  }

  NewsModel? _news;
  NewsModel? get news => _news;
  void setNews(NewsModel? value) {
    if (value == null) return;
    _news = value;
    notifyListeners();
  }

  bool isValid = false;

  String? errorMessage;
  void _setErrorMessageState(String value) {
    errorMessage = value;
    notifyListeners();
  }

  ImagePostViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    await Permission.storage.request();

    setNews(await cache.getNews());
    if (news == null) {
      return;
    }

    if (news!.title != null && news!.title != "") {
      controllerTitle.text = news!.title!;
    }

    if (news!.photo1desc != null && news!.photo1desc != "") {
      controllerSubtitleImg.text = news!.photo1desc!;
    }

    if (news!.cape != null && news!.cape != "") {
      selectedCape = File(news!.cape!);
    }

    if (news!.photo1 != null && news!.photo1 != "") {
      selectedImage1 = File(news!.photo1!);
    }

    if (news!.tag != null && news!.tag != "") {
      setTag(news!.tag!);
    }
  }

  Future<void> pickCape() async {
    try {
      final XFile? returnedImage = await myImage();
      if (returnedImage == null) return;

      selectedCape = File(returnedImage.path);
    } finally {
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? returnedImage = await myImage();
      if (returnedImage == null) return;

      selectedImage1 = File(returnedImage.path);
    } finally {
      notifyListeners();
    }
  }

  Future<XFile?> myImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void validate() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedCape == null) {
      _setErrorMessageState("Selecione uma foto de capa");
      return;
    }

    if (tag == null) {
      _setErrorMessageState("Selecione uma TAG");
      return;
    }

    if (controllerSubtitleImg.text.isNotEmpty && selectedImage1 == null) {
      _setErrorMessageState(
        "Você não pode colocar uma legenda na foto do conteúdo sem a foto de contéudo",
      );
      return;
    }
    NewsModel? news = await cache.getNews();
    if (news == null) {
      _setErrorMessageState(
        "Erro inesperado, tente refazer sua publicação. Volte para a tela inicial e tente de novo!",
      );
      return;
    }
    news.title = controllerTitle.text;
    news.cape = selectedCape!.path;
    if (selectedImage1 != null) news.photo1 = selectedImage1!.path;
    if (controllerSubtitleImg.text.isNotEmpty) {
      news.photo1desc = controllerSubtitleImg.text;
    }
    news.tag = tag;
    await cache.setNews(news);

    isValid = true;
    setNews(news);
  }

  @override
  void dispose() {
    tagNotifier.dispose();
    controllerTitle.dispose();
    controllerSubtitleImg.dispose();
    super.dispose();
  }
}
