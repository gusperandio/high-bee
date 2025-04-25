import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/viewmodel/register/register_view_model.dart';
import 'package:high_bee/views/validation/validation.dart';
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
          if (vm.isRegistered) {
            MSNavigate.replaceWithName(context, ValidationDatas.routeName);
          }

          if (vm.errorMessage != null) {
            Toast.show(context, vm.errorMessage!, variant: Variant.danger);
            vm.errorMessage = null;
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
                                  "Cadastro",
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColors.carvaoColor,
                                  ),
                                ),
                                Text(
                                  "Crie uma conta para acessar",
                                  style: const TextStyle(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 2,
                              children: [
                                TextFormField(
                                  controller: viewModel.emailController,
                                  cursorWidth: 1,
                                  cursorColor: PrimaryColors.carvaoColor,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
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
                                    floatingLabelStyle: const TextStyle(
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
                                          FieldValidator.validatePassword(
                                            value,
                                          ),
                                ),
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: viewModel.confirmController,
                                  cursorWidth: 1,
                                  cursorColor: PrimaryColors.carvaoColor,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
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
                                      (value) =>
                                          viewModel.validateConfirmPassword(),
                                ),
                                SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: Button.def(
                                    title:
                                        viewModel.isLoading ? "" : "Cadastrar",
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
                                      style: const TextStyle(
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
