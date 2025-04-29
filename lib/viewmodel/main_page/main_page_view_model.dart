import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/cache.dart' as highbeecache;
import 'package:provider/provider.dart';
import 'package:high_bee/viewmodel/competition/competition_view_model.dart';
import 'package:high_bee/viewmodel/home/home_view_model.dart';
import 'package:high_bee/viewmodel/profile/profile_view_model.dart';
import 'package:high_bee/viewmodel/saved/saved_view_model.dart';
import 'package:high_bee/viewmodel/strain/strain_view_model.dart';
import 'package:high_bee/views/competition/competition.dart';
import 'package:high_bee/views/home/home.dart';
import 'package:high_bee/views/profile/profile.dart';
import 'package:high_bee/views/saved/saved.dart';
import 'package:high_bee/views/strain/strain.dart';

class MainPageViewModel extends ChangeNotifier {
  final List<bool> _isPageInitialized = List.generate(5, (_) => false);
  final List<Widget?> _pages = List.filled(5, null);
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Widget?> get pages => _pages;
  List<bool> get initialized => _isPageInitialized;

  MainPageViewModel() {
    _initializePage(0);
  }

  void onTabTapped(int index) {
    _selectedIndex = index;
    _initializePage(index);
    notifyListeners();
  }

  void _initializePage(int index) {
    if (!_isPageInitialized[index]) {
      _pages[index] = _buildPage(index);
      _isPageInitialized[index] = true;
    }
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
          child: const HomePage(),
        );
      case 1:
        return ChangeNotifierProvider(
          create: (_) => CompetitionViewModel(),
          child: const CompetitionPage(),
        );
      case 2:
        return ChangeNotifierProvider(
          create: (_) => StrainViewModel(),
          child: const StrainPage(),
        );
      case 3:
        return ChangeNotifierProvider(
          create: (_) => SavedViewModel(),
          child: const SavedPage(),
        );
      case 4:
        return ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
          child: const ProfilePage(),
        );
      default:
        return SizedBox();
    }
  }

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

  Color get backgroundColor =>
      _selectedIndex == 4
          ? const Color(0xFFFED501)
          : PrimaryColors.highBeeColor;

  Future<bool> isTrained() async {
    return await highbeecache.Cache().getTrained();
  }
}
