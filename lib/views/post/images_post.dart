import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/accordions/accordion.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/dotted_card/dotted_card.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/validation/validation.dart';
//TECNOLOGIA OU ANTIGO
class ImagePostPage extends StatelessWidget {
  static const routeName = 'image_post';
  const ImagePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        body: KeyboardDismissOnTap(
      child: Column(children: [
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
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      )),
                ),
              ],
            )),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 15),
            color: PrimaryColors.claudeColor,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 20,
                children: [
                  Accordion(
                      background: PrimaryColors.claudeColor,
                      title: "Imagens",
                      description:
                          "Formato de como é exibido as imagens de \ncapa e como conteúdo da publicação",
                      content: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                            "assets/svg/rules/cape_rule.svg",
                            height: 340),
                      )),
                  DottedCard(
                    height: 110,
                    title: "Foto de capa",
                    description: "Obrigatório",
                    icon: SvgPicture.asset(
                      "assets/svg/image.svg",
                      colorFilter: ColorFilter.mode(
                          PrimaryColors.carvaoColor, BlendMode.srcIn),
                    ),
                  ),
                  DottedCard(
                    height: 160,
                    title: "Foto de conteúdo 01",
                    description: "Obrigatório",
                    icon: SvgPicture.asset(
                      "assets/svg/image.svg",
                      colorFilter: ColorFilter.mode(
                          PrimaryColors.carvaoColor, BlendMode.srcIn),
                    ),
                  ),
                  DottedCard(
                    height: 160,
                    title: "Foto de conteúdo 02",
                    description: "Obrigatório",
                    icon: SvgPicture.asset(
                      "assets/svg/image.svg",
                      colorFilter: ColorFilter.mode(
                          PrimaryColors.carvaoColor, BlendMode.srcIn),
                    ),
                  ),
                  DottedCard(
                    height: 160,
                    title: "Foto de conteúdo 03",
                    description: "Obrigatório",
                    icon: SvgPicture.asset(
                      "assets/svg/image.svg",
                      colorFilter: ColorFilter.mode(
                          PrimaryColors.carvaoColor, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
