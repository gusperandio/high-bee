import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class DottedCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget icon;
  final double height;

  const DottedCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: DottedBorder(
        color: const Color(0xFF8f9bba),
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        dashPattern: [5, 4],
        strokeWidth: 3,
        padding: EdgeInsets.all(0),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(left: 8.0), child: icon),
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 6),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 17,
                      color: PrimaryColors.carvaoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                description != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 6),
                      child: Text(
                        description!,
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          color: SecondaryColors.secondary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
