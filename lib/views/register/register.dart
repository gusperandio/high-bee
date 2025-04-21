import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/internet_check.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/register/validation_datas.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;
  bool _logged = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  void _togglePasswordView(int t) {
    setState(() {
      if (t == 1) {
        _obscurePass = !_obscurePass;
      }

      if (t == 2) {
        _obscureConfirm = !_obscureConfirm;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      await AuthService().signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      setState(() {
        _logged = true;
      });
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Esse e-mail já está sendo usado.';
          break;
        case 'invalid-email':
          message = 'E-mail inválido.';
          break;
        case 'weak-password':
          message = 'Senha fraca. Use no mínimo 6 caracteres.';
          break;
        default:
          message = 'Ocorreu um erro inesperado.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: SecondaryColors.danger,
          content: Text(
            message,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: KeyboardDismissOnTap(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: PrimaryColors.highBeeColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: GestureDetector(
                      onTap: () => {MSNavigate.toRoot(context)},
                      child: SvgPicture.asset(
                        'assets/svg/arrow-left.svg',
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 26,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cadastrar",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            Text(
                              "Crie uma conta para acessar",
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 12),
                        child: Watermaker(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 35,
                  bottom: 15,
                ),
                color: PrimaryColors.offWhiteColor,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 6,
                          children: [
                            TextFormField(
                              controller: _emailController,
                              cursorWidth: 1,
                              cursorColor: PrimaryColors.carvaoColor,
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(
                                  color: PrimaryColors.carvaoColor,
                                ),
                                labelText: 'E-mail',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu e-mail';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              cursorWidth: 1,
                              cursorColor: PrimaryColors.carvaoColor,
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(
                                  color: PrimaryColors.carvaoColor,
                                ),
                                labelText: 'Senha',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    _obscurePass
                                        ? "assets/svg/eye-off.svg"
                                        : "assets/svg/eye.svg",
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      PrimaryColors.carvaoColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  onPressed: () => _togglePasswordView(1),
                                ),
                              ),
                              obscureText: _obscurePass,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe a senha';
                                } else if (value.length < 6) {
                                  return 'A senha precisa ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: _confirmController,
                              cursorWidth: 1,
                              cursorColor: PrimaryColors.carvaoColor,
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(
                                  color: PrimaryColors.carvaoColor,
                                ),
                                labelText: 'Confirme a senha',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: SvgPicture.asset(
                                    _obscureConfirm
                                        ? "assets/svg/eye-off.svg"
                                        : "assets/svg/eye.svg",
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      PrimaryColors.carvaoColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  onPressed: () => _togglePasswordView(2),
                                ),
                              ),
                              obscureText: _obscureConfirm,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Confirme a senha';
                                } else if (value != _passwordController.text) {
                                  return 'As senhas não coincidem';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: Button.def(
                                title: _loading ? "" : "Acessar",
                                startContent:
                                    _loading
                                        ? SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: PrimaryColors.carvaoColor,
                                          ),
                                        )
                                        : SizedBox.shrink(),
                                onPressed:
                                    _loading
                                        ? null
                                        : () async {
                                          bool offline =
                                              await ConnectivityStatusChecker.isOffline();
                                          if (offline) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    SecondaryColors.danger,
                                                content: Text(
                                                  "Sem conexão com a internet!",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Urbanist',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                            return;
                                          }
                                          await signUpUser();
                                          if (_logged) {
                                            MSNavigate.toName(
                                              context,
                                              ValidationDatas.routeName,
                                            );
                                          }
                                        },
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                fontColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Separator(
                        color: Colors.black,
                        content: const Text(
                          "Ou cadastre com",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        size: 1,
                      ),
                      GestureDetector(
                        onTap:
                            () => {
                              () async {
                                try {
                                  final userCredential =
                                      await AuthService().signInWithGoogle();

                                  if (userCredential.user != null) {
                                    MSNavigate.toName(
                                      context,
                                      ValidationDatas.routeName,
                                    );
                                  } else {
                                    throw Exception();
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Erro ao entrar com Google. Tente novamente.',
                                      ),
                                    ),
                                  );
                                }
                              },
                            },
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: PrimaryColors.carvaoColor,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              spacing: 12,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/google-icon.svg',
                                  width: 32,
                                  height: 32,
                                ),
                                Text(
                                  "Entrar com Google",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
