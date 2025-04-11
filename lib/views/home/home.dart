import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String myBackground = 'assets/images/Screenshot_0.png'; // valor inicial

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    final SvgPicture svgHouse = SvgPicture.asset(
      'assets/svg/house.svg',
      width: 42,
      height: 42,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
    List<String> generateTitles(int count) {
      return List<String>.generate(count, (index) => "");
    }

    List<Widget> generateWidgets(int count) {
      return List<Widget>.generate(count, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.white,
              width: 250,
              height: 400,
              child: Center(
                child: Image.asset(
                  'assets/images/Screenshot_$index.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      });
    }

    final List<Widget> myContent = generateWidgets(6);

    return AppContainer(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Expanded(
              child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(myBackground),
                  fit: BoxFit.cover,
                ),
              ), // Cor de fundo com transparência
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent, // para manter a cor original
              ),
            ),
            Column(children: [
              Expanded(
                child: VerticalCardPager(
                  titles: generateTitles(myContent.length),
                  images: myContent,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPageChanged: (page) {
                    if (page! % 1 == 0) {
                      final int index = page.toInt();
                      setState(() {
                        myBackground = 'assets/images/Screenshot_$index.png';
                      });
                    }
                  },
                  onSelectedItem: (index) {
                    print("Selected Item: $index");
                  },
                  initialPage: 0,
                  align: ALIGN.LEFT,
                  physics: ClampingScrollPhysics(),
                ),
              ),
            ]),
          ]))
        ]));
  }
}
