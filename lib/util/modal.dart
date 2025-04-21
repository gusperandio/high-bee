import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/styles/colors.dart';

Future<dynamic> modalBottom({
  required BuildContext context,
  required Widget content,
  required String title,
  bool btnClose = true,
  bool divider = true,
  Color? closeColor,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 32, top: 26, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  if (btnClose)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        'assets/svg/x.svg',
                        width: 32,
                        height: 32,
                        colorFilter: ColorFilter.mode(
                            closeColor ?? SecondaryColors.danger,
                            BlendMode.srcIn),
                      ),
                    ),
                ],
              ),
            ),
            if (divider) const Divider(thickness: 2, color: Color(0xFFE6E6E6)),
            content,
          ],
        ),
      );
    },
  );
}
