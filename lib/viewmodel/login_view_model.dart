import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/internet_check.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePass = false;
  bool isLoading = false;
  bool isLogged = false;
  bool hasNavigated = false;
  String? errorMessage;

  void togglePasswordVisibility() {
    obscurePass = !obscurePass;
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
      additionalValidation:
          (email) => EmailValidator.validate(email) ? null : 'Email incoerente',
    );
  }

  String? validatePassword(String? value) {
    return validateField(value: value, emptyMessage: 'Informe a senha');
  }

  Future<void> signUpWithGoogle() async {
    try {
      final userCredential = await AuthService().signInWithGoogle();
      isLogged = userCredential.user != null;
      errorMessage =
          isLogged ? null : "Erro ao entrar com Google. Tente novamente.";
    } catch (e) {
      errorMessage = "Erro ao entrar com Google. Tente novamente.";
    } finally {
      notifyListeners();
    }
  }

  Future<void> signInUser() async {
    if (await ConnectivityStatusChecker.isOffline()) {
      errorMessage = "Sem conexão com a internet!";
      notifyListeners();
      return;
    }

    if (!formKey.currentState!.validate()) return;

    _setLoadingState(true);

    try {
      await Future.delayed(const Duration(seconds: 3));
      await AuthService().signInWithEmailAndPassword(
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
    return 'Usuário ou senha incorretos!';
  }

  void _setLoadingState(bool state) {
    isLoading = state;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
