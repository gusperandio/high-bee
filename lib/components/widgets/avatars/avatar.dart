import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/styles/colors.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool border;
  final VoidCallback? onTap;

  const Avatar(
      {super.key,
      this.imageUrl,
      required this.size,
      required this.border,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    const String assetName = 'assets/svg/perfil.svg';
    final Widget svg = SvgPicture.asset(
      assetName,
      width: size * 0.7,
      height: size * 0.7,
      colorFilter: ColorFilter.mode(const Color(0xFFb8c5f3), BlendMode.srcIn),
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: size,
        height: size,
        child: CircleAvatar(
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          backgroundColor: border
              ? (imageUrl != null
                  ? PrimaryColors.highBeeColor
                  : PrimaryColors.offWhiteColor)
              : (imageUrl != null ? Colors.white : PrimaryColors.offWhiteColor),
          child: imageUrl == null ? svg : null,
        ),
      ),
    );
  }
}
