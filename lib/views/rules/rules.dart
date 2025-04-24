import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/views/rules/widgets/build_row_rules.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/rules/rules_view_model.dart';
import 'package:high_bee/views/loading/loading.dart';
import 'package:high_bee/views/rules/widgets/privacy_policy.dart';
import 'package:high_bee/views/rules/widgets/rdc_cards.dart';
import 'package:high_bee/views/rules/widgets/terms_of_use.dart';
import 'package:provider/provider.dart';

class RulesPage extends StatefulWidget {
  static const routeName = 'rules';
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RulesViewModel>();

    return Consumer<RulesViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: PrimaryColors.carvaoColor,
                content: Text(vm.errorMessage!),
              ),
            );
            vm.errorMessage = null;
            return;
          }

          if (vm.isComplete) {
            MSNavigate.toName(context, LoadingPage.routeName);
          }
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
                        RDCards(),
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
                        ...viewModel.rules
                            .where((rule) => rule['ruledValid'] == true)
                            .map((rule) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                child: BuildRowRules(
                                  title: rule['context'],
                                  phrase: rule['phrase'],
                                  validRules: rule['ruledValid'],
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
                        ...viewModel.rules
                            .where((rule) => rule['ruledValid'] == false)
                            .map((rule) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 24,
                                ),
                                child: BuildRowRules(
                                  title: rule['context'],
                                  phrase: rule['phrase'],
                                  validRules: rule['ruledValid'],
                                ),
                              );
                            }),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 0),
                          child: Separator(
                            color: SecondaryColors.primary,
                            content: Text(
                              "Informações importantes!",
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
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 0,
                                      color: PrimaryColors.offWhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color:
                                              viewModel.warningPrivacy
                                                  ? SecondaryColors.danger
                                                  : Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => PrivacyPolicyModal(
                                                  onTap:
                                                      viewModel.acceptPrivacy,
                                                ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                !viewModel.acceptedPrivacy
                                                    ? "assets/svg/book-open.svg"
                                                    : "assets/svg/book-open-check.svg",
                                                height: 32,
                                                width: 32,
                                                colorFilter: ColorFilter.mode(
                                                  viewModel.warningPrivacy
                                                      ? SecondaryColors.danger
                                                      : !viewModel
                                                          .acceptedPrivacy
                                                      ? SecondaryColors
                                                          .secondary
                                                      : SecondaryColors.success,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              Text(
                                                'Políticas de \nPrivacidade',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                'Visualizar políticas',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Urbanist',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Card(
                                      elevation: 0,
                                      color: PrimaryColors.offWhiteColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color:
                                              viewModel.warningTerms
                                                  ? SecondaryColors.danger
                                                  : Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => TermsOfUseModal(
                                                  onTap: viewModel.acceptTerms,
                                                ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                !viewModel.acceptedTerms
                                                    ? "assets/svg/book-open.svg"
                                                    : "assets/svg/book-open-check.svg",
                                                height: 32,
                                                width: 32,
                                                colorFilter: ColorFilter.mode(
                                                  viewModel.warningTerms
                                                      ? SecondaryColors.danger
                                                      : !viewModel.acceptedTerms
                                                      ? SecondaryColors
                                                          .secondary
                                                      : SecondaryColors.success,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                'Termos de \nuso',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 6),
                                              Text(
                                                'Visualizar Termos',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Urbanist',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 6,
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    viewModel.updateText(value);
                                  },
                                  controller: viewModel.nameController,
                                  cursorWidth: 1,
                                  cursorColor: PrimaryColors.carvaoColor,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: TextStyle(
                                      color: PrimaryColors.carvaoColor,
                                    ),
                                    labelText: 'Nome e Sobrenome',
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
                                          FieldValidator.validateName(value),
                                ),

                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24,
                          ),
                          child: Column(
                            spacing: 22,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    activeColor: PrimaryColors.highBeeColor,
                                    checkColor: Colors.black,
                                    value: viewModel.isChecked,
                                    onChanged:
                                        (bool? value) =>
                                            viewModel.checkBox(value),
                                  ),

                                  Flexible(
                                    child: GestureDetector(
                                      onTap:
                                          () => viewModel.checkBox(
                                            !viewModel.isChecked,
                                          ),
                                      child: Text(
                                        "Eu ${viewModel.name}, li e concordo com as regras e termos de uso. Em caso de descumprimento, \naceito que minha conta seja bloqueada.",
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        maxLines: 6,
                                        textAlign: TextAlign.start,
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
                                    viewModel.save();
                                  },
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  fontColor: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 30),
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
        );
      },
    );
  }
}
