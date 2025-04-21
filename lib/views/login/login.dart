import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/services/auth/auth_service.dart';
import 'package:high_bee/util/internet_check.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/views/login/recovery_password.dart';
import 'package:high_bee/views/register/validation_datas.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _logged = false;

  bool _obscurePass = true;

  void _togglePasswordView() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUserIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: Loading(size: 120));
        },
      );
      await Future.delayed(const Duration(seconds: 3));

      await AuthService().signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      setState(() {
        _logged = true;
      });
    } on FirebaseAuthException catch (e) {
      String message =
          e.code == 'user-not-found'
              ? 'Usuário não encontrado'
              : 'Usuário ou senha incorretos!';

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
      Navigator.pop(context);
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
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
                              "Entre com sua \nconta",
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
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
                                  onPressed: () => _togglePasswordView(),
                                ),
                              ),
                              obscureText: _obscurePass,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap:
                                      () => {
                                        MSNavigate.toName(
                                          context,
                                          RecoveryPasswordPage.routeName,
                                        ),
                                      },
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Esqueceu a senha? ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Recuperar',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 15,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.bold,
                                            color: PrimaryColors.highBeeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: Button.def(
                                title: _loading ? "Carregando..." : "Acessar",
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

                                          await signUserIn();
                                          if (_logged) {
                                            authState.login();
                                            if (!context.mounted) return;
                                            MSNavigate.toRoot(context);
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
                      const SizedBox(height: 32),
                      Separator(
                        color: Colors.black,
                        content: const Text(
                          "Ou acesse com",
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
                      const SizedBox(height: 16),
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
