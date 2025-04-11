import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/login/login.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = 'welcome';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      body: Column(children: [
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Image.asset(
            'assets/images/Screenshot_3.png',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            color: Color(0xFFFCF5FF),
            child: Column(
              spacing: 18,
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
                    fontSize: 18,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: Button.def(
                    title: "Primeiro acesso",
                    onPressed: () => {MSNavigate.toName(context, "register")},
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
                    onPressed: () => {
                      MSNavigate.toName(
                        context,
                        LoginPage.routeName,
                      ),
                    },
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
