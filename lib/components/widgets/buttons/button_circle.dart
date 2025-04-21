import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class ButtonCircle extends StatefulWidget {
  final Widget content;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color hoverColor;

  const ButtonCircle._internal({
    required this.content,
    required this.onPressed,
    required this.backgroundColor,
    required this.hoverColor,
  });

  factory ButtonCircle.info(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.primary,
      hoverColor: const Color(0xFF5091C7),
    );
  }

  factory ButtonCircle.success(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.success,
      hoverColor: const Color(0xFF008554),
    );
  }

  factory ButtonCircle.warning(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.warning,
      hoverColor: const Color(0xFFDA996E),
    );
  }

  factory ButtonCircle.danger(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.danger,
      hoverColor: const Color(0xFFB82E3E),
    );
  }

  factory ButtonCircle.def(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: SecondaryColors.def,
      hoverColor: PrimaryColors.highBeeColor,
    );
  }

  factory ButtonCircle.black(
      {required Widget content, required VoidCallback onPressed}) {
    return ButtonCircle._internal(
      content: content,
      onPressed: onPressed,
      backgroundColor: const Color(0xFF000000),
      hoverColor: const Color(0xFF222222),
    );
  }

  @override
  ButtonCircleState createState() => ButtonCircleState();
}

class ButtonCircleState extends State<ButtonCircle> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(const CircleBorder()),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(20)),
        backgroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered)) {
            return widget.hoverColor;
          }
          return widget.backgroundColor;
        }),
      ),
      onPressed: widget.onPressed,
      child: widget.content,
    );
  }
}
