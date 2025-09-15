class ZipCode {
  final String value;
  bool get isValid => value.length == 8;

  ZipCode(String rawValue) : value = _sanitize(rawValue);

  static String _sanitize(String input) {
    // Remove tudo que não for número
    return input.replaceAll(RegExp(r'\D'), '');
  }

  /// Retorna o CEP no formato: 99.999-999
  String get mask {
    if (value.length != 8) return value;

    final firstPart = value.substring(0, 2);
    final secondPart = value.substring(2, 5);
    final thirdPart = value.substring(5, 8);

    return '$firstPart.$secondPart-$thirdPart';
  }

  factory ZipCode.empty() {
    return ZipCode('');
  }

  @override
  String toString() => value;
}
