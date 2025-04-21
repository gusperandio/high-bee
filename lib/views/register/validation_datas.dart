import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/modal.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/register/rules.dart';
import 'package:intl/intl.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';

class ValidationDatas extends StatefulWidget {
  static const routeName = 'validation_data';
  const ValidationDatas({super.key});

  @override
  State<ValidationDatas> createState() => _ValidationDatasState();
}

class _ValidationDatasState extends State<ValidationDatas> {
  DateTime? selectedDate;
  String? country;
  String? intention;
  final dateFormat = DateFormat('dd/MM/yyyy');
  String? validationMessage;
  bool isValid = false;

  bool isOver18(DateTime date) {
    final today = DateTime.now();
    final age =
        today.year -
        date.year -
        ((today.month < date.month ||
                (today.month == date.month && today.day < date.day))
            ? 1
            : 0);
    return age >= 18;
  }

  final controller = BoardDateTimeController();

  void onValidationComplete() {
    if (validationMessage != null && validationMessage!.contains('✅')) {
      Navigator.pop(context, true);
    } else {
      Navigator.pop(context, false);
    }
  }

  void _pickDate() async {
    final now = DateTime.now();
    final result = await showBoardDateTimePicker(
      radius: 12,
      enableDrag: false,
      headerWidget: Watermaker(),
      controller: controller,
      context: context,
      pickerType: DateTimePickerType.date,
      initialDate: selectedDate ?? now.subtract(const Duration(days: 365 * 18)),
      minimumDate: DateTime(1950),
      maximumDate: now,
      options: BoardDateTimeOptions(
        boardTitle: 'Selecione sua data de nascimento',
        pickerSubTitles: BoardDateTimeItemTitles(
          day: 'Dia',
          month: 'Mês',
          year: 'Ano',
        ),
        pickerFormat: PickerFormat.dmy,
        languages: BoardPickerLanguages.en(),
      ),
      barrierColor: PrimaryColors.highBeeColor,
      customCloseButtonBuilder: (
        BuildContext context,
        isValid,
        onValidationComplete,
      ) {
        return GestureDetector(
          onTap: onValidationComplete,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/svg/check-check.svg',
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                SecondaryColors.success,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
        validationMessage = null;
      });
    }
  }

  void _validateAge() {
    if (selectedDate == null) {
      setState(() {
        validationMessage = 'Por favor, selecione sua data de nascimento.';
      });
      return;
    }

    if (isOver18(selectedDate!)) {
      setState(() {
        validationMessage = '✅ Acesso permitido. Você é maior de 18 anos.';
      });
    } else {
      setState(() {
        validationMessage =
            '🚫 Acesso negado. Você precisa ter pelo menos 18 anos.';
      });
    }
  }

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

  final List<Map<String, String>> southAmericanCountries = [
    {'country': 'Argentina', 'flag': 'assets/svg/flags/flag-ar.svg'},
    {'country': 'Brasil', 'flag': 'assets/svg/flags/flag-br.svg'},
    {'country': 'Chile', 'flag': 'assets/svg/flags/flag-cl.svg'},
    {'country': 'Colômbia', 'flag': 'assets/svg/flags/flag-co.svg'},
    {'country': 'Equador', 'flag': 'assets/svg/flags/flag-ec.svg'},
    {'country': 'Paraguai', 'flag': 'assets/svg/flags/flag-py.svg'},
    {'country': 'Peru', 'flag': 'assets/svg/flags/flag-pe.svg'},
    {'country': 'Uruguai', 'flag': 'assets/svg/flags/flag-uy.svg'},
  ];

  final List<Map<String, String>> cannabisIntentions = [
    {'area': 'Saúde - Médico(a)'},
    {'area': 'Saúde - Dentista'},
    {'area': 'Saúde - Psicólogo(a)'},
    {'area': 'Saúde - Enfermeiro(a)'},
    {'area': 'Saúde - Terapeuta holístico'},
    {'area': 'Direito - Advogado(a)'},
    {'area': 'Direito - Consultor jurídico'},
    {'area': 'Educação - Pesquisador(a)'},
    {'area': 'Educação - Professor(a)'},
    {'area': 'Educação - Estudante'},
    {'area': 'Tecnologia - Desenvolvedor(a) de software'},
    {'area': 'Tecnologia - Engenheiro(a) de hardware'},
    {'area': 'Tecnologia - Cientista de dados'},
    {'area': 'Empreendedorismo - Cultivador(a)'},
    {'area': 'Empreendedorismo - Fabricante de produtos'},
    {'area': 'Empreendedorismo - Distribuidor(a)'},
    {'area': 'Empreendedorismo - Dono(a) de growshop/headshop'},
    {'area': 'Empreendedorismo - Criador de conteúdo'},
    {'area': 'Indústria - Cosméticos com cannabis'},
    {'area': 'Indústria - Alimentos com cannabis'},
    {'area': 'Indústria - Bebidas infusionadas'},
    {'area': 'Indústria - Produtos veterinários'},
    {'area': 'Bem-estar - Yoga e meditação com cannabis'},
    {'area': 'Bem-estar - Aromaterapia'},
    {'area': 'Bem-estar - Fitoterapia'},
    {'area': 'Agronegócio - Pesquisa genética de sementes'},
    {'area': 'Agronegócio - Automatização de cultivo'},
    {'area': 'Sustentabilidade - Bioenergia a partir do cânhamo'},
    {'area': 'Sustentabilidade - Bioconstrução com cânhamo'},
    {'area': 'Moda - Confecção com tecidos de cânhamo'},
    {'area': 'Arte e Cultura - Artista visual'},
    {'area': 'Arte e Cultura - Músico(a)'},
    {'area': 'Arte e Cultura - Produtor(a) cultural'},
    {'area': 'Ativismo - Redução de danos'},
    {'area': 'Ativismo - Direitos humanos'},
    {'area': 'Ativismo - Educação canábica'},
    {'area': 'Marketing - Publicidade no setor canábico'},
    {'area': 'Marketing - Influenciador(a) digital'},
    {'area': 'Outros - Curioso(a) sobre o tema'},
    {'area': 'Outros - Usuário(a) medicinal'},
    {'area': 'Outros - Usuário(a) recreativo consciente'},
  ];

  @override
  Widget build(BuildContext context) {
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
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                              color: PrimaryColors.carvaoColor,
                            ),
                          ),
                          Text(
                            "Que tal a gente se conhecer \nmelhor?",
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
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
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
                          padding: const EdgeInsets.only(right: 8.0, top: 6),
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
                        border: Border.all(color: Colors.black),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/calendar.svg',
                          width: 32,
                          height: 32,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          'Idade',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          selectedDate == null
                              ? 'Selecione sua data de nascimento'
                              : dateFormat.format(selectedDate!),
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/svg/arrow-right.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        onTap: _pickDate,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/flag.svg',
                          width: 32,
                          height: 32,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          'Nacionalidade',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          country == null
                              ? 'Em qual pais você vive?'
                              : country!,
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/svg/arrow-right.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        onTap: () async {
                          final selectedCountry = await modalBottom(
                            context: context,
                            content: selectionContent(
                              context: context,
                              titleKey: "country", // ou "area"
                              items: southAmericanCountries,
                              initialValue: country,
                            ),
                            title: "Selecione o seu país!",
                            closeColor: Colors.black,
                          );

                          if (selectedCountry != null) {
                            setState(() {
                              country = selectedCountry;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/speech.svg',
                          width: 32,
                          height: 32,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          'Intenção',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          intention == null
                              ? 'Qual area você atua no mercado de cannabis?'
                              : intention!,
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: SvgPicture.asset(
                          'assets/svg/arrow-right.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        onTap: () async {
                          final selectedIntention = await modalBottom(
                            context: context,
                            content: selectionContent(
                              context: context,
                              titleKey: "area",
                              items: cannabisIntentions,
                              initialValue: intention,
                            ),
                            title: "Demonstre-nos sua \nintenção!",
                            closeColor: Colors.black,
                          );

                          if (selectedIntention != null) {
                            setState(() {
                              intention = selectedIntention;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Button.def(
                        title: "Continuar",
                        onPressed: () {
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

    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Validação de Idade'),
    //     centerTitle: true,
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [

    //         const SizedBox(height: 20),
    //         ElevatedButton(
    //           onPressed: _validateAge,
    //           child: const Text('Validar Idade'),
    //         ),
    //         const SizedBox(height: 20),

    //       ],
    //     ),
    //   ),
    // );
  }
}
