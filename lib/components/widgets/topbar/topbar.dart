import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/navigate.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const TopBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          title:
              title != null
                  ? Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: PrimaryColors.carvaoColor,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  )
                  : null,

          centerTitle: true,
          toolbarHeight: 120,
          backgroundColor: PrimaryColors.highBeeColor,
          automaticallyImplyLeading: false,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 68, left: 22),
          child: GestureDetector(
            onTap: () => {MSNavigate.back(context)},
            child: SvgPicture.asset(
              'assets/svg/arrow-left.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
