import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/accordions/accordion.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/post/images_post.dart';

class TitlePostPage extends StatelessWidget {
  static const routeName = 'title_post';
  const TitlePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: KeyboardDismissOnTap(
        child: Column(
          children: [
            Container(
              height: 72,
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
                color: PrimaryColors.claudeColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 20,
                    children: [
                      const SizedBox(height: 100),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Text(
                              "Informe o título da publicação",
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 16,
                              ),
                            ),
                            TextFormField(
                              cursorWidth: 1,
                              cursorColor: PrimaryColors.carvaoColor,
                              decoration: InputDecoration(
                                floatingLabelStyle: const TextStyle(
                                  color: PrimaryColors.carvaoColor,
                                ),
                                labelText: 'Título',
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
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu nome';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: Button.def(
                                title: "PRÓXIMO",
                                onPressed: () {
                                  MSNavigate.toName(
                                    context,
                                    ImagePostPage.routeName,
                                  );
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
