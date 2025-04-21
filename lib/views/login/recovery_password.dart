import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';

class RecoveryPasswordPage extends StatelessWidget {
  static const routeName = 'recovery_password';
  const RecoveryPasswordPage({super.key});

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
                      onTap: () => {MSNavigate.back(context)},
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
                              "Recuperar \nminha conta",
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 6,
                          children: [
                            TextFormField(
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
                            SizedBox(
                              width: double.infinity,
                              child: Button.def(
                                title: "Recuperar",
                                onPressed: () {
                                  // authState.login();
                                  // MSNavigate.toRoot(context);
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
