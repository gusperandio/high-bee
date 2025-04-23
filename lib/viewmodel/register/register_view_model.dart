import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/util/internet_check.dart';

class RegisterViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;
  String get confirm => confirmController.text;

  bool obscurePass = true;
  bool obscureConfirm = true;
  bool isLoading = false;
  bool isRegistered = false;
  String? errorMessage;

  void togglePasswordVisibility({required bool isPassword}) {
    if (isPassword) {
      obscurePass = !obscurePass;
    } else {
      obscureConfirm = !obscureConfirm;
    }
    notifyListeners();
  }

  String? validateConfirmPassword() {
    return FieldValidator.validateConfirmPassword(confirm, password);
  }

  Future<void> signUpWithGoogle() async {
    try {
      final userCredential = await AuthService().signInWithGoogle();
      isRegistered = userCredential.user != null;
      errorMessage =
          isRegistered ? null : "Erro ao entrar com Google. Tente novamente.";
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
        email: email.trim(),
        password: passwordController.text,
      );
      isRegistered = true;
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
      case 'user-disabled':
        return 'Você foi banido!';
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
