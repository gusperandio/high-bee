import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/competition/competition.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/post/title_post.dart';
import 'package:high_bee/views/profile/profile.dart';
import 'package:high_bee/views/saved/saved.dart';
import 'package:high_bee/views/strain/strain.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 4});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  final List<bool> _isPageInitialized = List.generate(5, (_) => false);
  final List<Widget?> _pages = List.filled(5, null);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _initializePage(_selectedIndex);

    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  void _initializePage(int index) {
    if (!_isPageInitialized[index]) {
      _pages[index] = _buildPage(index);
      _isPageInitialized[index] = true;
    }
  }

  final TextStyle tabTextStyle = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    fontFamily: 'Urbanist',
  );

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

  static const TextStyle optionStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return CompetitionPage();
      case 2:
        return StrainPage();
      case 3:
        return SavedPage();
      case 4:
        return ProfilePage();
      default:
        return SizedBox();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _initializePage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                mini: true,
                onPressed: () {
                  MSNavigate.toName(context, TitlePostPage.routeName);
                },
                backgroundColor: PrimaryColors.highBeeColor,
                child: SvgPicture.asset(
                  'assets/svg/feather.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor:
          _selectedIndex == 4
              ? const Color(0xFFFED501)
              : PrimaryColors.highBeeColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(5, (index) {
          return _isPageInitialized[index]
              ? _pages[index]!
              : const SizedBox(); // vazio se ainda não acessou
        }),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: PrimaryColors.carvaoColor,
              elevation: 10,
              unselectedItemColor: const Color(0xFF8F9BBA),
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: getIcon('house', isSelected: _selectedIndex == 0),
                  label: "Inicio",
                ),
                BottomNavigationBarItem(
                  icon: getIcon('layers', isSelected: _selectedIndex == 1),
                  label: "Concurso",
                ),
                BottomNavigationBarItem(
                  icon: getIcon('cannabis', isSelected: _selectedIndex == 2),
                  label: "Strains",
                ),
                BottomNavigationBarItem(
                  icon: getIcon('bookmark', isSelected: _selectedIndex == 3),
                  label: "Exemplo",
                ),
                BottomNavigationBarItem(
                  icon: getIcon('user', isSelected: _selectedIndex == 4),
                  label: "Perfil",
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor:
                  _selectedIndex != 2
                      ? PrimaryColors.highBeeColor
                      : Colors.greenAccent,
              unselectedLabelStyle: optionStyle,
              selectedLabelStyle: optionStyle,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
