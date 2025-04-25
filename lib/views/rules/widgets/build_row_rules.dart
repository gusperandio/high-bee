import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';

class BuildRowRules extends StatelessWidget {
  final String title;
  final String phrase;
  final bool validRules;

  const BuildRowRules({
    super.key,
    required this.title,
    required this.phrase,
    required this.validRules,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: validRules ? SecondaryColors.success : SecondaryColors.danger,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: validRules ? const Color(0xFFE6F8F2) : const Color(0xFFFEEDEF),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          validRules
              ? SvgPicture.asset(
                'assets/svg/check-check.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  SecondaryColors.success,
                  BlendMode.srcIn,
                ),
              )
              : SvgPicture.asset(
                'assets/svg/octagon-x.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  SecondaryColors.danger,
                  BlendMode.srcIn,
                ),
              ),
          const SizedBox(width: 12),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                        color: PrimaryColors.carvaoColor,
                      ),
                    ),
                    TextSpan(
                      text: ' $phrase',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.normal,
                        color: PrimaryColors.carvaoColor,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
