import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/views/competition/competition.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/profile/profile.dart';
import 'package:high_bee/views/stickers/stciker.dart';
import 'package:high_bee/views/strain/strain.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final TextStyle tabTextStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Urbanist');

  Widget getIcon(String path, {bool isSelected = false}) {
    final colorFolder =
        isSelected ? PrimaryColors.highBeeColor : const Color(0xFF8f9bba);

    if (path == 'cannabis') {
      final colorSpecific = isSelected ? Colors.lightGreenAccent : Colors.green;
      return SvgPicture.asset(
        'assets/svg/$path.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(colorSpecific, BlendMode.srcIn),
      );
    }

    return SvgPicture.asset(
      'assets/svg/$path.svg',
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(colorFolder, BlendMode.srcIn),
    );
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CompetitionPage(),
    StrainPage(),
    StickerPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: AppContainer(
        body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: PrimaryColors.carvaoColor,
            elevation: 0,
            unselectedItemColor: const Color(0xFF8F9BBA),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: getIcon('house', isSelected: _selectedIndex == 0),
                  label: "Inicio"),
              BottomNavigationBarItem(
                  icon: getIcon('layers', isSelected: _selectedIndex == 1),
                  label: "Concurso"),
              BottomNavigationBarItem(
                  icon: getIcon('cannabis', isSelected: _selectedIndex == 2),
                  label: "Strains"),
              BottomNavigationBarItem(
                  icon: getIcon('trophy', isSelected: _selectedIndex == 3),
                  label: "Exemplo"),
              BottomNavigationBarItem(
                  icon: getIcon('user', isSelected: _selectedIndex == 4),
                  label: "Perfil"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: _selectedIndex != 2
                ? PrimaryColors.highBeeColor
                : Colors.greenAccent,
            unselectedLabelStyle: optionStyle,
            selectedLabelStyle: optionStyle,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
