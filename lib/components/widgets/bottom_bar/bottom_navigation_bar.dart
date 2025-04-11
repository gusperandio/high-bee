import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:high_bee/components/styles/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final TextStyle optionStyle;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.optionStyle =
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  });

  Widget getIcon(String path, {bool isSelected = false}) {
    final colorFolder =
        isSelected ? PrimaryColors.highBeeColor : const Color(0xFF8f9bba);
    return SvgPicture.asset(
      'assets/svg/$path.svg',
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(colorFolder, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent),
      child: BottomNavigationBar(
        backgroundColor: PrimaryColors.offWhiteColor,
        elevation: 0,
        unselectedItemColor: const Color(0xFF8F9BBA),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: getIcon('home', isSelected: selectedIndex == 0),
              label: "INÍCIO"),
          BottomNavigationBarItem(
              icon: getIcon('apps', isSelected: selectedIndex == 1),
              label: "EVENTOS"),
          BottomNavigationBarItem(
              icon: getIcon('jornal', isSelected: selectedIndex == 2),
              label: "CONTEÚDOS"),
          BottomNavigationBarItem(
              icon: getIcon('perfil', isSelected: selectedIndex == 3),
              label: "PERFIL"),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: PrimaryColors.highBeeColor,
        unselectedLabelStyle: optionStyle,
        selectedLabelStyle: optionStyle,
        onTap: onItemTapped,
      ),
    );
  }
}
