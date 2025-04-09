import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    final List<String> titles = [
      "RED",
      "YELLOW",
      "BLACK",
      "CYAN",
      "BLUE",
      "GREY",
    ];

    List<Widget> generateWidgets(int count) {
      return List<Widget>.generate(count, (index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 12),
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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                authState.logout();
              },
              child: Text("Logout"),
            ),
            Expanded(
              child: VerticalCardPager(
                  titles: titles,
                  images: generateWidgets(6),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPageChanged: (page) {
                    // optional
                  },
                  onSelectedItem: (index) {
                    print("Selected Item: $index");
                  },
                  initialPage: 0, //optional
                  align: ALIGN.LEFT, //optional
                  physics: ClampingScrollPhysics() //optional
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
