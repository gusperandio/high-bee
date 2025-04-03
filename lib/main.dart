import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/firebase_options.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "RED",
      "YELLOW",
      "BLACK",
      "CYAN",
      "BLUE",
      "GREY",
    ];

    final List<Widget> images = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.grey,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: VerticalCardPager(
                    titles: titles, // required
                    images: images, // required
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold), // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      // optional
                    },
                    initialPage: 0, // optional
                    align: ALIGN.RIGHT, // optional
                    physics: ClampingScrollPhysics() // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultItemBuilder(BuildContext context, int itemIndex, int realIndex) {
  final bool isCenter = realIndex == 0;
  final double zIndex = isCenter ? 2.0 : 1.0; // Item central sempre no topo

  return Transform.translate(
    offset: Offset(0, isCenter ? 0 : (realIndex > 0 ? -120 : 120)),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
        border: isCenter
            ? Border.all(
                color: Colors.blueAccent,
                width: 2,
              )
            : null,
      ),
      width: 250,
      height: 400,
      child: Center(
        child: Image.asset('assets/images/Screenshot_$itemIndex.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight),
      ),
    ),
  );
}

class CarouselDemo extends StatelessWidget {
  final InfiniteScrollController _controller = InfiniteScrollController();

  CarouselDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carrossel Vertical')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: SizedBox(
            height: double.infinity,
            child: InfiniteCarousel.builder(
                itemCount: 5,
                itemExtent: 400,
                controller: _controller,
                axisDirection: Axis.vertical,
                loop: true,
                onIndexChanged: (index) => print('Índice atual: $index'),
                itemBuilder: defaultItemBuilder),
          ),
        ),
      ),
    );
  }
}
