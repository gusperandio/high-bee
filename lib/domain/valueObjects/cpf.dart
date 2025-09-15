class CPF {
  final String value;
  bool isValid;

  CPF._(this.value, {this.isValid = true});

  factory CPF.empty() => CPF._('');

  factory CPF(String raw) {
    final sanitized = _sanitize(raw);

    if (!_isValidCpf(sanitized)) {
      return CPF._(sanitized, isValid: false);
    }

    return CPF._(sanitized, isValid: true);
  }

  static String _sanitize(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static bool _isValidCpf(String cpf) {
    if (cpf.length != 11) return false;
    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) return false;

    List<int> digits = cpf.split('').map(int.parse).toList();

    int calculateDigit(List<int> numbers, int multiplier) {
      int sum = 0;
      for (int i = 0; i < numbers.length; i++) {
        sum += numbers[i] * (multiplier - i);
      }
      int mod = (sum * 10) % 11;
      return mod == 10 ? 0 : mod;
    }

    int digit1 = calculateDigit(digits.sublist(0, 9), 10);
    int digit2 = calculateDigit(digits.sublist(0, 10), 11);

    return digit1 == digits[9] && digit2 == digits[10];
  }

  @override
  String toString() => _formatCpf(value);

  static String _formatCpf(String cpf) {
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is CPF && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
