import 'package:flutter/material.dart';
import 'package:high_bee/components/enum/enums.dart';
import 'package:high_bee/components/styles/colors.dart';

class Button extends StatefulWidget {
  final String? title;
  final Widget? startContent;
  final Widget? endContent;
  final Color? fontColor;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color hoverColor;
  final EdgeInsets padding;
  final RoundedRectangleBorder shape;

  const Button._internal({
    this.title,
    this.startContent,
    this.endContent,
    this.fontColor,
    required this.onPressed,
    required this.backgroundColor,
    required this.hoverColor,
    required this.padding,
    required this.shape,
  });

  factory Button.info({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.primary,
      hoverColor: const Color(0xFF5091C7),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
    );
  }

  factory Button.success({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.success,
      hoverColor: const Color(0xFF008554),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
    );
  }

  factory Button.warning({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.warning,
      hoverColor: const Color(0xFFDA996E),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
    );
  }

  factory Button.danger({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.danger,
      hoverColor: const Color(0xFFB82E3E),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
    );
  }

  factory Button.def({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: PrimaryColors.highBeeColor,
      hoverColor: const Color.fromARGB(157, 241, 184, 41),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
    );
  }

  factory Button.black({
    String? title,
    Widget? startContent,
    Widget? endContent,
    Color? fontColor,
    RadiusBtn? borderRadius,
    EdgeInsets? padding,
    void Function()? onPressed,
  }) {
    return Button._internal(
      title: title,
      startContent: startContent,
      endContent: endContent,
      fontColor: fontColor,
      onPressed: onPressed,
      backgroundColor: const Color(0xFF000000),
      hoverColor: const Color(0xFF222222),
      padding: padding ?? _defaultPadding(title),
      shape: _defaultRadius(borderRadius ?? RadiusBtn.medium),
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
  ButtonState createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return widget.hoverColor;
          }
          return widget.backgroundColor;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(widget.shape),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(widget.padding),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
      onPressed: widget.onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.startContent != null) widget.startContent!,
          if (widget.title != null)
            Text(
              widget.title!.toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: widget.fontColor ?? Colors.white),
              textAlign: TextAlign.center,
            ),
          if (widget.endContent != null) widget.endContent!,
        ],
      ),
    );
  }
}
