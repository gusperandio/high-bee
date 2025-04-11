import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/enum/enums.dart';
import 'package:high_bee/components/styles/colors.dart';

class ToastStyle {
  final Color background;
  final Color border;
  final Color iconBackground;
  final Color iconBorder;
  final String iconPath;

  ToastStyle({
    required this.background,
    required this.border,
    required this.iconBackground,
    required this.iconBorder,
    required this.iconPath,
  });
}

class ToastStyles {
  static final Map<Variant, ToastStyle> highStyles = {
    Variant.success: ToastStyle(
      background: SecondaryColors.success,
      border: const Color(0xFF01a369),
      iconBackground: const Color(0xFF018354),
      iconBorder: const Color(0xFF01915d),
      iconPath: 'assets/svg/check.svg',
    ),
    Variant.warning: ToastStyle(
      background: const Color.fromARGB(255, 255, 220, 105),
      border: const Color(0xFFE6D65F),
      iconBackground: const Color(0xFFb8ab4c),
      iconBorder: const Color(0xFFccbe54),
      iconPath: 'assets/svg/atualizar.svg',
    ),
    Variant.danger: ToastStyle(
      background: const Color(0xFFE11900),
      border: const Color(0xFFCB1700),
      iconBackground: const Color(0xFFa21200),
      iconBorder: const Color(0xFFb41400),
      iconPath: 'assets/svg/erro.svg',
    ),
    Variant.info: ToastStyle(
      background: PrimaryColors.highBeeColor,
      border: const Color(0xFF2647c5),
      iconBackground: const Color(0xFF0B2574),
      iconBorder: const Color(0xFF223fae),
      iconPath: 'assets/svg/chat-duplo.svg',
    ),
  };

  static final Map<Variant, ToastStyle> lowStyles = {
    Variant.success: ToastStyle(
      background: const Color(0xFFE6F8F2),
      border: const Color(0xFFcfe0da),
      iconBackground: const Color(0xFF018354),
      iconBorder: const Color(0xFF01915d),
      iconPath: 'assets/svg/check.svg',
    ),
    Variant.warning: ToastStyle(
      background: const Color(0xFFFFFDF0),
      border: const Color(0xFFE6E4D8),
      iconBackground: const Color(0xFFe6d65f),
      iconBorder: const Color(0xFFffed69),
      iconPath: 'assets/svg/atualizar.svg',
    ),
    Variant.danger: ToastStyle(
      background: const Color(0xFFFEEDEF),
      border: const Color(0xFFe5d6d8),
      iconBackground: const Color(0xFFdc3e51),
      iconBorder: const Color(0xFFf4455a),
      iconPath: 'assets/svg/erro.svg',
    ),
    Variant.info: ToastStyle(
      background: const Color(0xFFECF9FF),
      border: const Color(0xFFCAD6DB),
      iconBackground: const Color(0xFF5ba5e2),
      iconBorder: const Color(0xFF65b7fb),
      iconPath: 'assets/svg/chat-duplo.svg',
    ),
  };
}

class Toast {
  static void show(
    BuildContext context,
    String message, {
    required TypeWidget typed,
    required Variant variant,
    Duration? duration,
    required bool hasIcon,
    required bool hasButton,
    VoidCallback? onUndo,
    Color? xColor,
  }) {
    final style = typed == TypeWidget.high
        ? ToastStyles.highStyles[variant]!
        : ToastStyles.lowStyles[variant]!;

    Color textColor = (typed == TypeWidget.high && variant != Variant.warning)
        ? Colors.white
        : Colors.black;
    final Widget svgX = SvgPicture.asset(
      'assets/svg/x.svg',
      width: 16,
      height: 16,
      colorFilter: ColorFilter.mode(
        xColor ?? (typed == TypeWidget.high ? Colors.white : Colors.black),
        BlendMode.srcIn,
      ),
    );
    final snackBar = SnackBar(
      content: GestureDetector(
        onTap: () => {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
        child: Row(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (hasIcon)
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: style.iconBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: style.iconBorder, width: 3.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    style.iconPath,
                    width: 20,
                    height: 20,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            Expanded(
              child: Text(
                message,
                softWrap: true,
                maxLines: 3,
                style: TextStyle(
                  fontSize: hasButton ? 14 : 16,
                  color: textColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () =>
                  {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0), child: svgX),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: style.border, width: 1.4),
      ),
      duration: duration ?? const Duration(seconds: 4),
      backgroundColor: style.background,
      behavior: SnackBarBehavior.floating,
      elevation: 2,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
