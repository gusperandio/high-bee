import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/internet_check.dart';

class RegisterViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscurePass = false;
  bool obscureConfirm = false;
  bool isLoading = false;
  bool isLogged = false;
  String? errorMessage;

  void togglePasswordVisibility({required bool isPassword}) {
    if (isPassword) {
      obscurePass = !obscurePass;
    } else {
      obscureConfirm = !obscureConfirm;
    }
    notifyListeners();
  }

  String? validateField({
    required String? value,
    required String emptyMessage,
    String? Function(String)? additionalValidation,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    return additionalValidation?.call(value);
  }

  String? validateEmail(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Por favor, insira seu e-mail',
      additionalValidation: (email) =>
          EmailValidator.validate(email) ? null : 'Email incoerente',
    );
  }

  String? validatePassword(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Informe a senha',
      additionalValidation: (password) =>
          password.length >= 6 ? null : 'A senha precisa ter pelo menos 6 caracteres',
    );
  }

  String? validateConfirmPassword(String? value) {
    return validateField(
      value: value,
      emptyMessage: 'Confirme a senha',
      additionalValidation: (confirmPassword) =>
          confirmPassword == passwordController.text ? null : 'As senhas não coincidem',
    );
  }

  Future<void> signUpWithGoogle() async {
    try {
      final userCredential = await AuthService().signInWithGoogle();
      isLogged = userCredential.user != null;
      errorMessage = isLogged ? null : "Erro ao entrar com Google. Tente novamente.";
    } catch (e) {
      errorMessage = "Erro ao entrar com Google. Tente novamente.";
    } finally {
      notifyListeners();
    }
  }

  Future<void> signUpUser() async {
    if (await ConnectivityStatusChecker.isOffline()) {
      errorMessage = "Sem conexão com a internet!";
      notifyListeners();
      return;
    }

    if (!formKey.currentState!.validate()) return;

    _setLoadingState(true);

    try {
      await AuthService().signUpWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      isLogged = true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _getFirebaseAuthErrorMessage(e.code);
    } finally {
      _setLoadingState(false);
    }
  }

  String _getFirebaseAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'Esse e-mail já está sendo usado.';
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'weak-password':
        return 'Senha fraca. Use no mínimo 6 caracteres.';
      default:
        return 'Ocorreu um erro inesperado.';
    }
  }

  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
