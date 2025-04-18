import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/loading/loading_page.dart';

class RulesPage extends StatelessWidget {
  static const routeName = 'rules';
  const RulesPage({super.key});

  Widget _buildRowRules(String text, bool validRules, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color:
                validRules ? SecondaryColors.success : SecondaryColors.danger,
            width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          validRules
              ? SvgPicture.asset(
                  'assets/svg/check-check.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      SecondaryColors.success, BlendMode.srcIn),
                )
              : SvgPicture.asset(
                  'assets/svg/octagon-x.svg',
                  width: 24,
                  height: 24,
                  colorFilter:
                      ColorFilter.mode(SecondaryColors.danger, BlendMode.srcIn),
                ),
          const SizedBox(width: 12),
          Flexible(
              child: Text(
            text,
            softWrap: true,
            overflow: TextOverflow.visible,
            maxLines: 6,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
              color: PrimaryColors.carvaoColor,
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> agreeRules = [
      {
        'rule':
            "Compartilhar informações educacionais sobre cannabis, CBD e cânhamo, desde que sejam baseadas em estudos científicos ou regulamentações oficiais.",
        'ruleValid': true
      },
      {
        'rule':
            "Relatar experiências pessoais sobre o uso de produtos com CBD ou cânhamo, desde que não façam alegações terapêuticas ou promessas de cura.",
        'ruleValid': true
      },
      {
        'rule':
            "Divulgar produtos que sejam legalmente autorizados pela Anvisa, como produtos à base de cannabis registrados e regulamentados para uso medicinal.",
        'ruleValid': true
      },
      {
        'rule':
            "Participar de discussões sobre o cultivo de cânhamo industrial, desde que seja para fins permitidos pela legislação (ex.: produção de fibras, alimentos ou cosméticos não medicinais).",
        'ruleValid': true
      }
    ];

    final List<Map<String, dynamic>> disagreeRules = [
      {
        'rule':
            "Fazer propaganda ou venda de produtos derivados de cannabis que não estejam devidamente registrados ou autorizados pela Anvisa.",
        'ruleValid': false
      },
      {
        'rule':
            "Divulgar tratamentos ou curas milagrosas que envolvem o uso de cannabis ou CBD.",
        'ruleValid': false
      },
      {
        'rule':
            "Oferecer instruções sobre o cultivo doméstico de cannabis para uso pessoal ou recreativo.",
        'ruleValid': false
      },
      {
        'rule':
            "Promover produtos ou métodos de uso que sejam proibidos pela legislação brasileira.",
        'ruleValid': false
      },
      {
        'rule':
            "Divulgar conteúdos que incentivem o uso recreativo de cannabis, especialmente para menores de idade.",
        'ruleValid': false
      },
      {
        'rule':
            "Publicar informações falsas ou enganosas sobre os efeitos da cannabis, CBD ou cânhamo.",
        'ruleValid': false
      }
    ];

    bool isChecked = false;

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
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            color: PrimaryColors.offWhiteColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(0),
              child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Separator(
                          color: SecondaryColors.success,
                          content: Text("Você pode",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColors.carvaoColor)),
                          size: 2),
                    ),
                    ...agreeRules.map((rule) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: _buildRowRules(
                            rule['rule'], rule['ruleValid'], context),
                      );
                    }),
                    // Image.asset(
                    //   "assets/images/smile.png",
                    //   fit: BoxFit.cover,
                    //   width: 150,
                    //   height: 110,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Separator(
                          color: SecondaryColors.danger,
                          content: Text("Você NÃO pode",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColors.carvaoColor)),
                          size: 2),
                    ),
                    ...disagreeRules.map((rule) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 24),
                        child: _buildRowRules(
                            rule['rule'], rule['ruleValid'], context),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 24),
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            spacing: 22,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    activeColor: PrimaryColors.highBeeColor,
                                    checkColor: Colors.black,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Flexible(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isChecked = !isChecked;
                                            });
                                          },
                                          child: Text(
                                            "Eu li e concordo com as regras e termos de uso. Em caso de descumprimento, \naceito que minha conta seja bloqueada.",
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            maxLines: 6,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              color: PrimaryColors.carvaoColor,
                                            ),
                                          )))
                                ],
                              ),
                              SizedBox(
                                width: 120,
                                child: Button.def(
                                  title: "Continuar",
                                  onPressed: () {
                                    if (isChecked) {
                                      MSNavigate.toName(
                                          context, LoadingPage.routeName);
                                    } else {
                                      // Show a message to the user
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              PrimaryColors.carvaoColor,
                                          content: const Text(
                                            "Você precisa concordar com as regras.",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  fontColor: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ]

                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  // SizedBox(
                  //   width: 120,
                  //   child: Button.def(
                  //     title: "Continuar",
                  //     onPressed: () {},
                  //     padding: const EdgeInsets.symmetric(vertical: 16),
                  //     fontColor: Colors.black,
                  //   ),
                  // ),
                  // Loading(size: 120),
                  ),
            ),
          ),
        )
      ]),
    );
  }
}
