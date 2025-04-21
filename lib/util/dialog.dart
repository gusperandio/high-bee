import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/styles/colors.dart';

class DialogHelper {
  static void show({
    required BuildContext context,
    required Widget content,
    String? title,
    TextStyle titleStyle = const TextStyle(
        fontFamily: 'Urbanist', fontSize: 24, fontWeight: FontWeight.bold),
    double? width,
    Color? closeColor,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: SizedBox(
            width: width ??
                MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(title ?? '', style: titleStyle)),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          'assets/svg/x.svg',
                          width: 22,
                          height: 22,
                          colorFilter: ColorFilter.mode(
                              closeColor ?? SecondaryColors.danger,
                              BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  content,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
