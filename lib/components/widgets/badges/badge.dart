import 'package:flutter/material.dart';
import 'package:high_bee/components/enum/enums.dart';
import 'package:high_bee/components/styles/colors.dart';

class BadgeCustom extends StatefulWidget {
  final String? text;
  final Widget iconDefault;
  final BadgeAlignment alignBadge;
  final Color backgroundColor;
  final Color hoverColor;

  const BadgeCustom._internal({
    this.text,
    required this.alignBadge,
    required this.iconDefault,
    required this.backgroundColor,
    required this.hoverColor,
  });

  factory BadgeCustom.danger(
      {String? text,
      required Widget iconDefault,
      required BadgeAlignment alignBadge}) {
    return BadgeCustom._internal(
      text: text,
      iconDefault: iconDefault,
      alignBadge: alignBadge,
      backgroundColor: SecondaryColors.danger,
      hoverColor: const Color(0xFFB82E3E),
    );
  }

  factory BadgeCustom.def(
      {String? text,
      required Widget iconDefault,
      required BadgeAlignment alignBadge}) {
    return BadgeCustom._internal(
      text: text,
      iconDefault: iconDefault,
      alignBadge: alignBadge,
      backgroundColor: SecondaryColors.def,
      hoverColor: PrimaryColors.highBeeColor,
    );
  }
  @override
  BadgeCustomState createState() => BadgeCustomState();
}

class BadgeCustomState extends State<BadgeCustom> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Badge(
              label: Text(widget.text ?? ""),
              padding: widget.text != null
                  ? EdgeInsets.symmetric(horizontal: 1, vertical: 6)
                  : EdgeInsets.all(0),
              backgroundColor: widget.backgroundColor,
              alignment: widget.alignBadge == BadgeAlignment.top
                  ? Alignment(0.5, -1)
                  : Alignment(0.8, 0.7),
              child: widget.iconDefault,
            ),
            onPressed: () {},
            iconSize: 48,
          ),
        ],
      ),
    );
  }
}
