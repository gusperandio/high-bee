enum ContactTypeEnum { email, telefone, sms, pergunta, password }

class ContactType {
  final ContactTypeEnum value;
  const ContactType._(this.value);

  factory ContactType.fromString(String value) {
    try {
      final normalized = value.toLowerCase();
      final enumValue = ContactTypeEnum.values.firstWhere((e) => e.name == normalized);
      return ContactType._(enumValue);
    } catch (_) {
      throw Exception('Invalid ContactType');
    }
  }

  @override
  String toString() => value.name;
}
