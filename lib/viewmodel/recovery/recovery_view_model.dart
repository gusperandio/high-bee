
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/services/auth/auth_service.dart';

class RecoveryViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String get email => emailController.text; 

  bool isLoading = false;
  bool isRecovered = false;
  String? errorMessage;

  Future<void> recoveryPassword() async {
    isLoading = true;
    notifyListeners();
    
    try {
      await AuthService().passwordReset(email);
      isRecovered = true; 
    } catch (e) {
      errorMessage = "Erro ao tentar recuperar senha.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}