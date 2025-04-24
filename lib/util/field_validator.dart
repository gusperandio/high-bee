import 'package:email_validator/email_validator.dart';

class FieldValidator {
  static String? validateField({
    required String? value,
    required String emptyMessage,
    String? Function(String)? additionalValidation,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    return additionalValidation?.call(value);
  }

  static String? validateEmail(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Por favor, insira seu e-mail',
      additionalValidation:
          (email) => EmailValidator.validate(email) ? null : 'Email incoerente',
    );
  }

  static String? validatePassword(String? value) {
    return validateField(value: value, emptyMessage: 'Informe a senha');
  }

  String? validatePasswordRegister(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Informe a senha',
      additionalValidation:
          (password) =>
              password.length >= 6
                  ? null
                  : 'A senha precisa ter pelo menos 6 caracteres',
    );
  }

  static String? validateConfirmPassword(String? value, String? compareValue) {
    return validateField(
      value: value,
      emptyMessage: 'Confirme a senha',
      additionalValidation:
          (confirmPassword) =>
              confirmPassword == compareValue
                  ? null
                  : 'As senhas não coincidem',
    );
  }

  static String? validateName(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Informe seu nome',
    );
  }
}
