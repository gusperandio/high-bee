import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/main_page/main_page_view_model.dart';
import 'package:high_bee/views/post/post.dart';
import 'package:high_bee/views/training/training.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainPageViewModel>();
    return Consumer<MainPageViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
        return AppContainer(
          floatingActionButton:
              viewModel.selectedIndex == 0
                  ? FloatingActionButton(
                    mini: true,
                    onPressed: () async { 
                      MSNavigate.toName(context, PostPage.routeName);
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
          backgroundColor: viewModel.backgroundColor,
          body: IndexedStack(
            index: viewModel.selectedIndex,
            children: List.generate(5, (index) {
              return viewModel.initialized[index]
                  ? viewModel.pages[index]!
                  : const SizedBox();
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
                      icon: viewModel.getIcon(
                        'house',
                        isSelected: viewModel.selectedIndex == 0,
                      ),
                      label: "Inicio",
                    ),
                    BottomNavigationBarItem(
                      icon: viewModel.getIcon(
                        'layers',
                        isSelected: viewModel.selectedIndex == 1,
                      ),
                      label: "Concurso",
                    ),
                    BottomNavigationBarItem(
                      icon: viewModel.getIcon(
                        'cannabis',
                        isSelected: viewModel.selectedIndex == 2,
                      ),
                      label: "Strains",
                    ),
                    BottomNavigationBarItem(
                      icon: viewModel.getIcon(
                        'bookmark',
                        isSelected: viewModel.selectedIndex == 3,
                      ),
                      label: "Exemplo",
                    ),
                    BottomNavigationBarItem(
                      icon: viewModel.getIcon(
                        'user',
                        isSelected: viewModel.selectedIndex == 4,
                      ),
                      label: "Perfil",
                    ),
                  ],
                  currentIndex: viewModel.selectedIndex,
                  selectedItemColor:
                      viewModel.selectedIndex != 2
                          ? PrimaryColors.highBeeColor
                          : Colors.greenAccent,

                  onTap: viewModel.onTabTapped,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
