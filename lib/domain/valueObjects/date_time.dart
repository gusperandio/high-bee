import 'package:intl/intl.dart';

class DateVO {
  final DateTime value;
  DateVO._(this.value);

  factory DateVO(String raw) {
    if (raw.isEmpty) {
      throw FormatException('Data não pode ser vazia');
    }

    DateTime? parsedDate = _tryParseIso(raw) ?? _tryParseCustom(raw) ?? _tryParseExtended(raw);

    if (parsedDate == null) {
      throw FormatException('Formato de data inválido: $raw');
    }

    return DateVO._(parsedDate);
  }

  factory DateVO.date(DateTime dateGMT) {
    return DateVO(dateGMT.toString());
  }

  /// Tenta fazer parse no formato ISO 8601 (yyyy-MM-dd)
  static DateTime? _tryParseIso(String raw) {
    try {
      return DateTime.parse(raw);
    } catch (_) {
      return null;
    }
  }

  /// Tenta fazer parse no formato dd/MM/yyyy
  static DateTime? _tryParseCustom(String raw) {
    try {
      List<String> parts = raw.split('/');
      if (parts.length != 3) return null;

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  String dateToPublishString(DateTime date) {
    return "Publicado ${DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(date)}";
  }

  /// Tenta fazer parse de algo como "sáb, 18/02/2023, 9:00 às 16:00"
  static DateTime? _tryParseExtended(String raw) {
    try {
      String clean = raw.replaceAll(RegExp(r'^[a-zA-ZçÇáéíóúãõâêîôû]+\s*,\s*'), '');
      clean = clean.split('às').first.trim();

      List<String> dateTimeParts = clean.split(',');
      if (dateTimeParts.length < 2) return null;

      String datePart = dateTimeParts[0].trim();
      String timePart = dateTimeParts[1].trim();

      List<String> dateParts = datePart.split('/');
      if (dateParts.length != 3) return null;

      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);

      List<String> timeParts = timePart.split(':');
      if (timeParts.length != 2) return null;

      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);

      return DateTime(year, month, day, hour, minute);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a data no formato ISO (yyyy-MM-dd)
  String get isoFormat =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

  /// Retorna a data no formato brasileiro (dd/MM/yyyy)
  String get brFormat =>
      '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year.toString()}';

  String get birthday => calculateAge(value);

  /// Retorna a data no formato brasileiro Publico dd de MM de yyyy
  String get stringPublishInto => "Publicado ${DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(value)}";

  /// Retorna a data no formato completo: yyyy-MM-dd HH:mm:ss
  String get fullIsoFormat {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');

    return '${value.year.toString().padLeft(4, '0')}-'
        '${doisDigitos(value.month)}-'
        '${doisDigitos(value.day)} '
        '${doisDigitos(value.hour)}:'
        '${doisDigitos(value.minute)}:'
        '${doisDigitos(value.second)}';
  }

  /// Novo: formato para eventos: sáb, 18/02/2023, 09:00
  String get eventFormat {
    final formatter = DateFormat('E, dd/MM/yyyy, HH:mm', 'pt_BR');
    return formatter.format(value);
  }

  /// Calcula a idade a partir de uma data de nascimento e retorna no formato português
  /// Exemplo: "25 anos", "1 ano"
  static String calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age == 1 ? '$age ano' : '$age anos';
  }

  @override
  String toString() => brFormat;

  String toStringPublish() => stringPublishInto;

  String toBirthdayString() => birthday;
}
