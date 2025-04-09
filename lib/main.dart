import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/app.dart';
import 'package:high_bee/firebase_options.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/cache.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); 
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Cache().init();
  runApp(
    ChangeNotifierProvider(
        create: (context) => AuthenticationState(), child: const MyApp()),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final List<String> titles = [
//       "RED",
//       "YELLOW",
//       "BLACK",
//       "CYAN",
//       "BLUE",
//       "GREY",
//     ];

//     final List<Widget> images = [
//       Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         width: 250,
//         height: 400,
//         child: Center(
//           child: Image.asset('assets/images/Screenshot_2.png',
//               width: double.infinity,
//               height: double.infinity,
//               fit: BoxFit.cover),
//         ),
//       ),
//       Container(
//         color: Colors.yellow,
//       ),
//       Container(
//         color: Colors.black,
//       ),
//       Container(
//         color: Colors.cyan,
//       ),
//       Container(
//         color: Colors.blue,
//       ),
//       Container(
//         color: Colors.grey,
//       ),
//     ];
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: VerticalCardPager(
//                   titles: titles, // required
//                   images: images, // required
//                   textStyle: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold), // optional
//                   onPageChanged: (page) {
//                     // optional
//                   },
//                   onSelectedItem: (index) {
//                     print("Selected Item: $index");
//                   },
//                   initialPage: 0, // optional
//                   align: ALIGN.RIGHT, // optional
//                   physics: ClampingScrollPhysics() // optional
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
