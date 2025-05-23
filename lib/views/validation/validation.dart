import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/age_alert/age_alert.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/modal.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/validation/validation_view_model.dart';
import 'package:high_bee/views/rules/rules.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

class ValidationDatas extends StatefulWidget {
  static const routeName = 'validation';
  const ValidationDatas({super.key});

  @override
  State<ValidationDatas> createState() => _ValidationDatasState();
}

class _ValidationDatasState extends State<ValidationDatas> {
  Widget selectionContent({
    required BuildContext context,
    required String titleKey,
    required List<Map<String, String>> items,
    String? initialValue,
  }) {
    String? selectedValue = initialValue;
    if (titleKey == "area") {
      items.sort((a, b) => a[titleKey]!.compareTo(b[titleKey]!));
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  SizedBox(
                    height: titleKey == "area" ? 430 : null,
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                            items.map((item) {
                              return RadioListTile<String>(
                                activeColor: PrimaryColors.highBeeColor,
                                selectedTileColor: PrimaryColors.carvaoColor,
                                value: item[titleKey]!,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                title: Row(
                                  children: [
                                    if (titleKey == "country")
                                      SvgPicture.asset(
                                        item["flag"]!,
                                        width: 32,
                                        height: 32,
                                      ),
                                    if (titleKey == "country")
                                      const SizedBox(width: 12),
                                    Flexible(
                                      child: Text(
                                        item[titleKey]!,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 55,
                    width: 120,
                    child:
                        selectedValue != null
                            ? Button.black(
                              title: "Selecionar",
                              onPressed: () {
                                Navigator.pop(context, selectedValue);
                              },
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              fontColor: Colors.white,
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ValidationViewModel>(
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
        });

        return AppContainer(
          body: Column(
            children: [
              Container(
                height: 300,
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
                                "Vamos lá",
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.bold,
                                  color: PrimaryColors.carvaoColor,
                                ),
                              ),
                              Text(
                                "Que tal a gente se conhecer \nmelhor?",
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
                    vertical: 1,
                    horizontal: 15,
                  ),
                  color: PrimaryColors.offWhiteColor,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                top: 6,
                              ),
                              child: Image.asset(
                                "assets/images/flor.png",
                                fit: BoxFit.cover,
                                width: 100,
                                height: 110,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: viewModel.alertAge),
                          ),
                          child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/svg/calendar.svg',
                              width: 32,
                              height: 32,
                              colorFilter: ColorFilter.mode(
                                viewModel.alertAge,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Idade',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: viewModel.alertAge,
                              ),
                            ),
                            subtitle: Text(
                              viewModel.age == null
                                  ? 'Selecione sua data de nascimento'
                                  : viewModel.dateFormat.format(viewModel.age!),
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                                color: viewModel.alertAge,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/svg/arrow-right.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                viewModel.alertAge,
                                BlendMode.srcIn,
                              ),
                            ),
                            onTap: () async {
                              viewModel.age = await showOmniDateTimePicker(
                                title: AgeAlert(),
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                padding: EdgeInsets.all(0),
                                barrierColor: PrimaryColors.highBeeColor,
                                barrierDismissible: true,
                                context: context,
                                type: OmniDateTimePickerType.date,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                  1600,
                                ).subtract(const Duration(days: 3652)),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,
                                secondsInterval: 1,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                constraints: const BoxConstraints(
                                  maxWidth: double.infinity,
                                  maxHeight: 800,
                                ),
                                transitionBuilder: (
                                  context,
                                  anim1,
                                  anim2,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: anim1.drive(
                                      Tween(begin: 0, end: 1),
                                    ),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(
                                  milliseconds: 200,
                                ),
                                selectableDayPredicate: (dateTime) {
                                  // Disable 25th Feb 2023
                                  if (dateTime == DateTime(2023, 2, 25)) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: PrimaryColors.carvaoColor,
                            ),
                          ),
                          child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/svg/flag.svg',
                              width: 32,
                              height: 32,
                              colorFilter: ColorFilter.mode(
                                PrimaryColors.carvaoColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Nacionalidade',
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            subtitle: Text(
                              viewModel.country == null
                                  ? 'Em qual pais você vive?'
                                  : viewModel.country!,
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/svg/arrow-right.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                PrimaryColors.carvaoColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            onTap: () async {
                              viewModel.country = await modalBottom(
                                context: context,
                                content: selectionContent(
                                  context: context,
                                  titleKey: "country",
                                  items: viewModel.southAmericanCountries,
                                  initialValue: viewModel.country,
                                ),
                                title: "Selecione o seu país!",
                                closeColor: Colors.black,
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: PrimaryColors.carvaoColor,
                            ),
                          ),
                          child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/svg/speech.svg',
                              width: 32,
                              height: 32,
                              colorFilter: ColorFilter.mode(
                                PrimaryColors.carvaoColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            title: Text(
                              'Intenção',
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            subtitle: Text(
                              viewModel.intention == null
                                  ? 'Qual area você atua no mercado de cannabis?'
                                  : viewModel.intention!,
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                                color: PrimaryColors.carvaoColor,
                              ),
                            ),
                            trailing: SvgPicture.asset(
                              'assets/svg/arrow-right.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                PrimaryColors.carvaoColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            onTap: () async {
                              viewModel.intention = await modalBottom(
                                context: context,
                                content: selectionContent(
                                  context: context,
                                  titleKey: "area",
                                  items: viewModel.cannabisIntentions,
                                  initialValue: viewModel.intention,
                                ),
                                title: "Demonstre-nos sua \nintenção!",
                                closeColor: Colors.black,
                              );
                            },
                          ),
                        ),

                        if (viewModel.isComplete)
                          SizedBox(
                            width: 120,
                            child: Button.def(
                              title: "Continuar",
                              onPressed: () async {
                                await viewModel.saveDatas();
                                MSNavigate.toName(context, RulesPage.routeName);
                              },
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              fontColor: Colors.black,
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
