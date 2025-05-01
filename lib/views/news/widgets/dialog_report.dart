import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/buttons/button_outline.dart';

class DialogReport extends StatefulWidget {
  final List<Map<String, String>> items;
  const DialogReport({super.key, required this.items});

  @override
  State<DialogReport> createState() => _DialogReportState();
}

class _DialogReportState extends State<DialogReport> {
  String type = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reportar Conteúdo',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/triangle-alert.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            SecondaryColors.danger,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SvgPicture.asset(
                      'assets/svg/x.svg',
                      width: 22,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        PrimaryColors.carvaoColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      widget.items.map((item) {
                        return RadioListTile<String>(
                          activeColor: SecondaryColors.danger,
                          selectedTileColor: PrimaryColors.carvaoColor,
                          value: item["title"]!,
                          groupValue: type,
                          onChanged: (value) {
                            setState(() {
                              type = value!;
                            });
                          },
                          title: Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"]!,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      item["description"]!,
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    ButtonOutline.black(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      title: "cancelar",
                    ),
                    Button.danger(
                      title: "Reportar",
                      onPressed: () {
                        if (type != "null" && type.isNotEmpty) {
                          Navigator.of(context).pop(type);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
