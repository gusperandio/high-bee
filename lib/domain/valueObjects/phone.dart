class Phone {
  final String value;
  bool get isValid => value.length == 11;

  Phone(String rawValue) : value = _sanitize(rawValue);

  String get mask {
    if (value == '') {
      return value;
    }
    final ddd = value.substring(0, 2);
    final firstPart = value.substring(2, 7);
    final secondPart = value.substring(7, 11);

    return '($ddd) $firstPart-$secondPart';
  }

  Phone._(this.value);

  factory Phone.empty() {
    return Phone._('');
  }

  static String _sanitize(String input) {
    // Remove tudo que não for número
    return input.replaceAll(RegExp(r'\D'), '');
  }

  @override
  String toString() => value;
}
