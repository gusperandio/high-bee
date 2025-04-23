import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/build/build_row_rules.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/models/datas/user.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/rules/rules_view_model.dart';
import 'package:high_bee/views/loading/loading_page.dart';
import 'package:high_bee/util/cache.dart' as highbeecache;
import 'package:provider/provider.dart';

class RulesPage extends StatefulWidget {
  static const routeName = 'rules';
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  Future<UserModel?> returnUser() async {
    return await highbeecache.Cache().getUser();
  }

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    final viewModel = context.watch<RulesViewModel>();

    return Consumer<RulesViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // if (vm.errorMessage != null) {
          //   Toast.show(context, vm.errorMessage!, variant: Variant.danger);
          //   vm.errorMessage = null;
          // }
        });

        return AppContainer(
          body: Column(
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
                                "REGRAS!!!",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColors.carvaoColor,
                                ),
                              ),
                              Text(
                                "Leia nossas regras com muita \natenção antes de continuar!",
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
                          padding: const EdgeInsets.only(right: 12, top: 12),
                          child: Watermaker(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
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
                            content: Text(
                              "Você pode",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            size: 2,
                          ),
                        ),
                        ...viewModel.agreeRules.map((rule) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            child: BuildRowRules(
                              text: rule['rule'],
                              validRules: rule['ruleValid'],
                            ),
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
                            content: Text(
                              "Você NÃO pode",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.bold,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            size: 2,
                          ),
                        ),
                        ...viewModel.disagreeRules.map((rule) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            child: BuildRowRules(
                              text: rule['rule'],
                              validRules: rule['ruleValid'],
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24,
                          ),
                          child: StatefulBuilder(
                            builder: (
                              BuildContext context,
                              StateSetter setState,
                            ) {
                              return Column(
                                spacing: 22,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
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
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Button.def(
                                      title: "Continuar",
                                      onPressed: () {
                                        if (isChecked) {
                                          MSNavigate.toName(
                                            context,
                                            LoadingPage.routeName,
                                          );
                                        } else {
                                          // Show a message to the user
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
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
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      fontColor: Colors.black,
                                    ),
                                  ),
                                  
                                ],
                              );
                            },
                          ),
                        ),
                      ],

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
              ),
            ],
          ),
        );
      },
    );
  }
}
