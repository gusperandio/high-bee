import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:lottie/lottie.dart';

class RulesPage extends StatelessWidget {
  static const routeName = 'rules';
  const RulesPage({super.key});

  Widget _buildAgreeRules(String text) {
    return Row(
      spacing: 12,
      children: [
        SvgPicture.asset(
          'assets/svg/check-check.svg',
          width: 24,
          height: 24,
          colorFilter:
              ColorFilter.mode(SecondaryColors.success, BlendMode.srcIn),
        ),
      ],
    );
  }

  Widget _buildDisagreeRules(String text) {
    return Row(
      spacing: 12,
      children: [
        SvgPicture.asset(
          'assets/svg/check.svg',
          width: 24,
          height: 24,
          colorFilter:
              ColorFilter.mode(SecondaryColors.danger, BlendMode.srcIn),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> agreeRules = [
      "Respeitar todos os membros da comunidade.",
      "Seguir as diretrizes de conduta estabelecidas.",
      "Reportar comportamentos inadequados.",
    ];

    final List<String> disagreeRules = [
      "Não toleramos discurso de ódio ou discriminação.",
      "Evitar spam ou mensagens irrelevantes.",
      "Não compartilhar informações pessoais de outros membros.",
    ];

    return AppContainer(
      body: Column(children: [
        Container(
            height: 220,
            width: double.infinity,
            color: PrimaryColors.highBeeColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(24),
                //   child: GestureDetector(
                //       onTap: () => {
                //             MSNavigate.back(context),
                //           },
                //       child: SvgPicture.asset(
                //         'assets/svg/arrow-left.svg',
                //         width: 24,
                //         height: 24,
                //         colorFilter:
                //             ColorFilter.mode(Colors.black, BlendMode.srcIn),
                //       )),
                // ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("REGRAS!!!",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColors.carvaoColor)),
                            Text(
                              "Leia nossas regras com muita \natenção antes de continuar!",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryColors.carvaoColor),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12, top: 12),
                        child: Watermaker(),
                      )
                    ]),
              ],
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            color: PrimaryColors.offWhiteColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(
                      "assets/images/smile.png",
                      fit: BoxFit.cover,
                      width: 150,
                      height: 110,
                    ),
                  ]),
                  SizedBox(
                    width: 120,
                    child: Button.def(
                      title: "Continuar",
                      onPressed: () {},
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      fontColor: Colors.black,
                    ),
                  ),
                  Loading(size: 120),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
