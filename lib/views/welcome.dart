import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/views/home/home.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    return AppContainer(
        body: SizedBox(
      height: screenHeight,
      child: Column(children: [
        SizedBox(
          height: screenHeight * 0.56,
          width: double.infinity,
          child: Image.asset(
            'assets/images/Screenshot_3.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: screenHeight * 0.4122,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFFCF5FF), // Tom aleatório como fundo
          ),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Bem-vindo a \nnossa causa!',
                style: TextStyle(
                  height: 1,
                  fontSize: 32,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Compartilhamos experiências com \nprodutos que a da vida oferece',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Button.def(
                  title: "Primeiro acesso",
                  onPressed: () => {},
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  fontColor: Colors.black,
                ),
              ),
              const Divider(
                  height: 0,
                  thickness: 1,
                  endIndent: 4,
                  indent: 4,
                  color: Colors.black12),
              SizedBox(
                width: double.infinity,
                child: Button.black(
                  title: "Tenho uma conta",
                  onPressed: () => {authState.login()},
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}


// return AppContainer(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: screenHeight,
//           child: Stack(
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.55,
//                 width: double.infinity,
//                 child: Image.asset(
//                   'assets/images/Screenshot_3.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                 top: screenHeight * 0.55,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFFCF5FF), // Tom aleatório como fundo
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(30),
//                     ),
//                   ),
//                   child: Column(
//                     spacing: 16,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Bem-vindo a \nnossa causa!',
//                         style: TextStyle(
//                           height: 1,
//                           fontSize: 32,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Text(
//                         'Compartilhamos experiências com \nprodutos que a da vida oferece',
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.yellow[700],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Primeiro acesso',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       const Divider(
//                           height: 0,
//                           thickness: 1,
//                           endIndent: 4,
//                           indent: 4,
//                           color: Colors.black12),
//                       Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Tenho uma conta',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );