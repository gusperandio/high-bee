import 'package:blur/blur.dart';
import 'package:flutter/material.dart'; 
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String myBackground = 'assets/images/Screenshot_0.png';
  @override
  Widget build(BuildContext context) {
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

    return Column(children: [
      Expanded(
          child: Stack(children: [
        Image.asset(
          myBackground,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          filterQuality: FilterQuality.low,
        ).blurred(
          blur: 10,
          colorOpacity: 0.1,
          overlay: Container(
            color: Colors.black12, // camada escura semi-transparente
          ),
        ),

        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        //   child: Container(
        //     color: Colors.transparent,
        //   ),
        // ),
        Column(children: [
          Expanded(
            child: VerticalCardPager(
              titles: generateTitles(myContent.length),
              images: myContent,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              onPageChanged: (page) async {
                if (page! % 1 == 0) {
                  final int index = page.toInt();
                  final newBg = 'assets/images/Screenshot_$index.png';

                  await precacheImage(AssetImage(newBg), context);

                  setState(() {
                    myBackground = newBg;
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
    ]);
  }
}
