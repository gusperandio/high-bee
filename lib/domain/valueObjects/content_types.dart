enum ContentsTypeEnum {
  posts,
  ebooks,
  videos,
  tendencias,
  modelos,
  arquivo,
  podcast,
  planilhas,
  guiadeinovacao,
  webstorie,
}

class ContentsType {
  final ContentsTypeEnum value;
  const ContentsType._(this.value);

  factory ContentsType.fromString(String value) {
    try {
      final normalized = value.toLowerCase();
      final enumValue = ContentsTypeEnum.values.firstWhere((e) => e.name == normalized);
      return ContentsType._(enumValue);
    } catch (_) {
      throw Exception('Invalid ContentTypes');
    }
  }

  @override
  String toString() => value.name;
}
