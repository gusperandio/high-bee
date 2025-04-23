import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/viewmodel/login/login_view_model.dart';
import 'package:high_bee/views/recovery/recovery.dart';
import 'package:high_bee/views/validation/validation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isDialogVisible = false;

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    final viewModel = context.watch<LoginViewModel>();
    return Consumer<LoginViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isLoading && !isDialogVisible) {
            isDialogVisible = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: Loading(size: 120)),
            );
          }

          if (!vm.isLoading && isDialogVisible) {
            isDialogVisible = false;
            Navigator.of(context, rootNavigator: true).pop(); // fecha o loading
          }

          if (vm.errorMessage != null) {
            Toast.show(context, vm.errorMessage!, variant: Variant.danger);
            vm.errorMessage = null;
          }

          if (vm.isLogged && !vm.hasNavigated) {
            vm.hasNavigated = true;

            if (!vm.isRegistered) {
              MSNavigate.toSpecific(context, ValidationDatas.routeName);
              return;
            }

            authState.login();
            MSNavigate.toRoot(context);
          }
        });

        return AppContainer(
          appBar: TopBar(),
          body: KeyboardDismissOnTap(
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  color: PrimaryColors.highBeeColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                                  "Acesse sua \nconta",
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
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 6,
                              children: [
                                TextFormField(
                                  controller: viewModel.emailController,
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
                                  validator:
                                      (value) =>
                                          FieldValidator.validateEmail(value),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: viewModel.passwordController,
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
                                        viewModel.obscurePass
                                            ? "assets/svg/eye-off.svg"
                                            : "assets/svg/eye.svg",
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                          PrimaryColors.carvaoColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      onPressed:
                                          () =>
                                              viewModel
                                                  .togglePasswordVisibility(),
                                    ),
                                  ),
                                  obscureText: viewModel.obscurePass,
                                  validator:
                                      (value) =>
                                          FieldValidator.validatePassword(
                                            value,
                                          ),
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
                                              RecoveryPage.routeName,
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
                                                color:
                                                    PrimaryColors.highBeeColor,
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
                                    title:
                                        viewModel.isLoading
                                            ? "Carregando..."
                                            : "Acessar",
                                    onPressed:
                                        viewModel.isLoading
                                            ? null
                                            : () async {
                                              await viewModel.signInUser();
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
                            onTap: () async {
                              await viewModel.signUpWithGoogle();
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
      },
    );
  }
}
