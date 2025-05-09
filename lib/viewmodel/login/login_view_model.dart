import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/services/user/user_service.dart';
import 'package:high_bee/util/cache.dart';
import 'package:high_bee/util/internet_check.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get email => emailController.text;
  String get password => passwordController.text;

  bool obscurePass = true;
  bool isLoading = false;
  bool isLogged = false;
  bool isRegistered = false;
  bool hasNavigated = false;
  String? errorMessage;

  void togglePasswordVisibility() {
    obscurePass = !obscurePass;
    notifyListeners();
  }

  Future<void> signUpWithGoogle() async {
    try {
      _setLoadingState(true);
      final userCredential = await AuthService().signInWithGoogle();
      isRegistered = await UserService().isUserRegistered();
      UserModel? user = await Cache().getUser();
      if (user != null) {
        user.avatar = userCredential.user!.photoURL;
        await Cache().setUser(user);
      }

      isLogged = userCredential.user != null;
      errorMessage =
          isLogged ? null : "Erro ao entrar com Google. Tente novamente.";
    } catch (e) {
      errorMessage = "Erro ao entrar com Google. Tente novamente.";
    } finally {
      _setLoadingState(false);
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
        email: email.trim(),
        password: password,
      );
      UserModel? user = await Cache().getUser();
      if (user == null && isRegistered) {
        user = await UserService().getUserDatas();
        await Cache().setUser(user!);
      }
      isRegistered = await UserService().isUserRegistered();
      isLogged = true;

    } on FirebaseAuthException catch (e) {
      errorMessage = _getFirebaseAuthErrorMessage(e.code);
    } finally {
      _setLoadingState(false);
    }
  }

  String _getFirebaseAuthErrorMessage(String errorCode) {
    return errorCode == 'user-disabled'
        ? 'Você foi banido!'
        : 'Usuário ou senha incorretos!';
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
