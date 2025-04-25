import 'package:flutter/material.dart';
import 'package:high_bee/components/enum/enums.dart';
import 'package:high_bee/components/styles/colors.dart';

class ButtonOutline extends StatefulWidget {
  final String? title;
  final Widget? startContent;
  final Widget? endContent;
  final VoidCallback onPressed;
  final bool hasBackground;
  final Color hoverColor;
  final Color borderColor;
  final EdgeInsets padding;
  final RoundedRectangleBorder shape;

  const ButtonOutline._internal({
    this.title,
    this.startContent,
    this.endContent,
    required this.onPressed,
    this.hasBackground = true,
    required this.hoverColor,
    required this.borderColor,
    required this.padding,
    required this.shape,
  });

  factory ButtonOutline.info({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x135091C7),
      borderColor: SecondaryColors.primary,
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  factory ButtonOutline.success({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x13008554),
      borderColor: SecondaryColors.success,
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  factory ButtonOutline.warning({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x13DA996E),
      borderColor: SecondaryColors.warning,
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  factory ButtonOutline.danger({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x13B82E3E),
      borderColor: SecondaryColors.danger,
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  factory ButtonOutline.def({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x132A50DA),
      borderColor: PrimaryColors.highBeeColor,
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  factory ButtonOutline.black({
    String? title,
    Widget? startContent,
    Widget? endContent,
    required VoidCallback onPressed,
    bool hasBackground = true,
  }) {
    return ButtonOutline._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      onPressed: onPressed,
      hasBackground: hasBackground,
      hoverColor: const Color(0x13222222),
      borderColor: const Color(0xFF000000),
      padding: _defaultPadding(title),
      shape: _defaultRadius(RadiusBtn.medium),
    );
  }

  static EdgeInsets _defaultPadding(String? title) {
    return title != null
        ? const EdgeInsets.symmetric(horizontal: 24, vertical: 10)
        : const EdgeInsets.symmetric(horizontal: 0, vertical: 14);
  }

  static RoundedRectangleBorder _defaultRadius(RadiusBtn radius) {
    switch (radius) {
      case RadiusBtn.none:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
      case RadiusBtn.small:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));
      case RadiusBtn.medium:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
      case RadiusBtn.large:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    }
  }

  @override
  ButtonOutlineState createState() => ButtonOutlineState();
}

class ButtonOutlineState extends State<ButtonOutline> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          return widget.hasBackground ? widget.hoverColor : Colors.transparent;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return BorderSide(color: widget.hoverColor);
          }
          return BorderSide(color: widget.borderColor);
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(widget.shape),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(widget.padding),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Visibility(
            visible: widget.startContent != null,
            child: widget.startContent ?? SizedBox.shrink(),
          ),
          Visibility(
            visible: widget.title != null,
            child: Text(
              widget.title!.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: widget.borderColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: widget.endContent != null,
            child: widget.endContent ?? SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
