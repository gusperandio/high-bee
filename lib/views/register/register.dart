import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/register_view_model.dart';
import 'package:high_bee/views/register/validation_datas.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();

    return Consumer<RegisterViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isLogged) {
            MSNavigate.toName(context, ValidationDatas.routeName);
          }
          if (vm.errorMessage != null) {
            Toast.show(context, vm.errorMessage!, SecondaryColors.danger);
            vm.errorMessage = null;
          }
        });

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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: PrimaryColors.offWhiteColor,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 16,
                      ),
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
                                      (value) => viewModel.validateEmail(value),
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
                                          () => viewModel
                                              .togglePasswordVisibility(
                                                isPassword: true,
                                              ),
                                    ),
                                  ),
                                  obscureText: viewModel.obscurePass,
                                  validator:
                                      (value) =>
                                          viewModel.validatePassword(value),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: viewModel.confirmController,
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
                                        viewModel.obscureConfirm
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
                                          () => viewModel
                                              .togglePasswordVisibility(
                                                isPassword: false,
                                              ),
                                    ),
                                  ),
                                  obscureText: viewModel.obscureConfirm,
                                  validator:
                                      (value) => viewModel
                                          .validateConfirmPassword(value),
                                ),
                                SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: Button.def(
                                    title: viewModel.isLoading ? "" : "Acessar",
                                    startContent:
                                        viewModel.isLoading
                                            ? SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color:
                                                    PrimaryColors.carvaoColor,
                                              ),
                                            )
                                            : SizedBox.shrink(),
                                    onPressed:
                                        viewModel.isLoading
                                            ? null
                                            : () async {
                                              await viewModel.signUpUser();
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
