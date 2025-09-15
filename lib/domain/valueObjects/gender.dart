// ignore: constant_identifier_names
enum GenderEnum { masculino, feminino, outros, nao_informado, empty }

class Gender {
  final GenderEnum value;
  Gender(this.value);
  const Gender._(this.value);

  factory Gender.fromString(String value) {
    try {
      final enumValue = GenderEnum.values.firstWhere((e) => e.name == value);
      return Gender._(enumValue);
    } catch (_) {
      throw ArgumentError('Invalid status: $value');
    }
  }

  String get displayName {
    switch (value) {
      case GenderEnum.masculino:
        return 'M';
      case GenderEnum.feminino:
        return 'F';
      case GenderEnum.outros:
        return 'O';
      case GenderEnum.nao_informado:
        return 'N';
      case GenderEnum.empty:
        return 'N';
    }
  }

  static List<String> get dropdownItems => ['Homem', 'Mulher', 'Outros', 'Não Informado'];

  static Gender fromDisplayName(String displayName) {
    switch (displayName) {
      case 'Homem':
        return Gender(GenderEnum.masculino);
      case 'Mulher':
        return Gender(GenderEnum.feminino);
      case 'Outros':
        return Gender(GenderEnum.outros);
      case 'Não Informado':
        return Gender(GenderEnum.nao_informado);
      default:
        return Gender(GenderEnum.empty);
    }
  }

  @override
  String toString() {
    if (value.name.isEmpty) {
      return '';
    }
    return '${value.name[0].toUpperCase()}${value.name.substring(1)}';
  }
}
