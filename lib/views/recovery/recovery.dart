import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/viewmodel/recovery/recovery_view_model.dart';
import 'package:provider/provider.dart';

class RecoveryPage extends StatelessWidget {
  static const routeName = 'recovery';
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecoveryViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.errorMessage != null) {
            Toast.show(
              context,
              viewModel.errorMessage!,
              variant: Variant.danger,
            );
            viewModel.errorMessage = null;
          }

          if (viewModel.isRecovered) {
            Toast.show(
              context,
              "Um e-mail de recuperação foi enviado",
              variant: Variant.success,
              duration: Duration(seconds: 2),
            );
          }
        });

        return AppContainer(
          resizeToAvoidBottomInset: false,
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
                                  "Recuperar \nminha conta",
                                  style: const TextStyle(
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
                    color: Colors.white,
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 35,
                            bottom: 15,
                          ),
                          child: Form(
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
                                SizedBox(
                                  width: double.infinity,
                                  child: Button.def(
                                    title:
                                        viewModel.isLoading ? "" : "Recuperar",
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
                                              FocusScope.of(context).unfocus();
                                              await viewModel
                                                  .recoveryPassword();
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 150,
                              child: Image.asset(
                                'assets/lottie/satisfy.gif',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
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
