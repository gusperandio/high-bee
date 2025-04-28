import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/styles/colors.dart';

class DropdownCustom extends StatelessWidget {
  final List<String> items;
  final String selected;
  final Color borderColor;
  final String? title;
  final TextStyle titleStyle;
  final Color backgroundColor;
  final double size;
  final bool? iconLeft;
  final bool? iconRight;
  final ValueChanged<String?> onChanged;

  const DropdownCustom._internal({
    required this.items,
    required this.size,
    required this.selected,
    this.title,
    this.iconLeft = false,
    this.iconRight = false,
    this.borderColor = PrimaryColors.carvaoColor,
    this.backgroundColor = Colors.white,
    this.titleStyle = const TextStyle(
      fontSize: 16,
      color: Color(0xFF222222),
      fontWeight: FontWeight.w400,
      fontFamily: "Figtree",
    ),
    required this.onChanged,
  });

  factory DropdownCustom.def({
    required List<String> items,
    required double size,
    required String selected,
    bool? iconLeft,
    bool? iconRight,
    String? title,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownCustom._internal(
      items: items,
      size: size,
      selected: selected,
      title: title,
      onChanged: onChanged,
      iconLeft: iconLeft ?? false,
      iconRight: iconRight ?? false,
    );
  }

  factory DropdownCustom.success({
    required List<String> items,
    required double size,
    required String selected,
    String? title,
    Color? backgroundColor,
    bool? iconLeft,
    bool? iconRight,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownCustom._internal(
      items: items,
      size: size,
      selected: selected,
      title: title,
      borderColor: SecondaryColors.success,
      backgroundColor: backgroundColor ?? const Color(0xffFAFCFE),
      onChanged: onChanged,
      iconLeft: iconLeft ?? false,
      iconRight: iconRight ?? false,
    );
  }

  factory DropdownCustom.danger({
    required List<String> items,
    required double size,
    required String selected,
    String? title,
    Color? backgroundColor,
    bool? iconLeft,
    bool? iconRight,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownCustom._internal(
      items: items,
      size: size,
      selected: selected,
      title: title,
      borderColor: SecondaryColors.danger,
      backgroundColor: backgroundColor ?? const Color(0xffFAFCFE),
      onChanged: onChanged,
      iconLeft: iconLeft ?? false,
      iconRight: iconRight ?? false,
    );
  }

  factory DropdownCustom.editable({
    required List<String> items,
    required double size,
    required String selected,
    String? title,
    Color? borderColor,
    Color? backgroundColor,
    bool? iconLeft,
    bool? iconRight,
    TextStyle? titleStyle,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownCustom._internal(
      items: items,
      size: size,
      selected: selected,
      title: title,
      borderColor: borderColor ?? PrimaryColors.carvaoColor,
      backgroundColor: backgroundColor ?? const Color(0xffFAFCFE),
      titleStyle:
          titleStyle ??
          const TextStyle(
            fontSize: 16,
            color: Color(0xFF222222),
            fontWeight: FontWeight.w400,
            fontFamily: "Figtree",
          ),
      onChanged: onChanged,
      iconLeft: iconLeft ?? false,
      iconRight: iconRight ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget svgIconDown = SvgPicture.asset(
      'assets/svg/chevron-down.svg',
      width: 18,
      height: 18,
      colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
    );
    final Widget svgIconLeft = SvgPicture.asset(
      'assets/svg/direita.svg',
      width: 16,
      height: 16,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(left: 2.0, bottom: 4),
            child: Text(
              title!.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        Container(
          width: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: DropdownMenu<String>(
            width: size,
            initialSelection: selected,
            trailingIcon: svgIconDown,
            selectedTrailingIcon: svgIconDown,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: backgroundColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
            ),
            textStyle: const TextStyle(
              color: Color(0xFF222222),
              fontWeight: FontWeight.w500,
              fontFamily: "Figtree",
            ),
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.transparent),
              surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.transparent, width: 1),
                ),
              ),
              elevation: WidgetStateProperty.all(22),
            ),
            enableFilter: true,
            onSelected: onChanged,
            dropdownMenuEntries:
                items.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String value = entry.value;

                  BorderRadius borderRadius;
                  if (index == 0) {
                    borderRadius = const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    );
                  } else if (index == items.length - 1) {
                    borderRadius = const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    );
                  } else {
                    borderRadius = BorderRadius.zero;
                  }

                  return DropdownMenuEntry(
                    leadingIcon: iconLeft! ? svgIconLeft : null,
                    trailingIcon: iconRight! ? svgIconLeft : null,
                    label: value,
                    value: value,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: borderRadius,
                          side: const BorderSide(
                            color: Color(0xFFdcdfe5),
                            width: 0.3,
                          ),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(10),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(12),
                      ),
                      overlayColor: WidgetStateProperty.all(
                        const Color(0xFFf4f7fe),
                      ),
                      textStyle: WidgetStateProperty.resolveWith<TextStyle>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.pressed) ||
                            states.contains(WidgetState.hovered)) {
                          return TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Figtree",
                          );
                        }
                        return TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF222222),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Figtree",
                        );
                      }),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
