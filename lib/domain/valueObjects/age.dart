class Age {
  final DateTime birthDate;

  Age(this.birthDate) {
    if (birthDate.isAfter(DateTime.now())) {
      throw ArgumentError('A data de nascimento não pode ser no futuro.');
    }
  }

  int get value {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  @override
  String toString() => '$value anos';
}
