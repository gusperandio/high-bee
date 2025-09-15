class Email {
  final String value;
  bool get isValid {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
    if (!emailRegex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  Email(this.value);

  factory Email.empty() {
    return Email('');
  }

  @override
  String toString() => value;
}
