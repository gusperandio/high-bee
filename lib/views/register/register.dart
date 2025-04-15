import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/views/register/validation_datas.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'register';
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        body: KeyboardDismissOnTap(
      child: Column(children: [
        Container(
            height: 300,
            width: double.infinity,
            color: PrimaryColors.highBeeColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: GestureDetector(
                      onTap: () => {MSNavigate.toRoot(context)},
                      child: SvgPicture.asset(
                        'assets/svg/arrow-left.svg',
                        width: 24,
                        height: 24,
                        colorFilter:
                            ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      )),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cadastrar",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: PrimaryColors.carvaoColor)),
                            Text(
                              "Crie uma conta para acessar",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: PrimaryColors.carvaoColor),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 12),
                        child: Watermaker(),
                      )
                    ]),
              ],
            )),
        Expanded(
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 15),
            color: PrimaryColors.offWhiteColor,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 6,
                      children: [
                        TextFormField(
                          cursorWidth: 1,
                          cursorColor: PrimaryColors.carvaoColor,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                TextStyle(color: PrimaryColors.carvaoColor),
                            labelText: 'Nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu nome';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          cursorWidth: 1,
                          cursorColor: PrimaryColors.carvaoColor,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                TextStyle(color: PrimaryColors.carvaoColor),
                            labelText: 'E-mail',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira seu e-mail';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          cursorWidth: 1,
                          cursorColor: PrimaryColors.carvaoColor,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                TextStyle(color: PrimaryColors.carvaoColor),
                            labelText: 'Senha',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: PrimaryColors.carvaoColor),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira sua senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Button.def(
                            title: "Cadastrar",
                            onPressed: () {
                              MSNavigate.toName(
                                  context, ValidationDatas.routeName);
                            },
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            fontColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Separator(
                      color: Colors.black,
                      content: const Text("Ou cadastre com",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500)),
                      size: 1),
                  SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: PrimaryColors.carvaoColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          spacing: 12,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg/google-icon.svg',
                              width: 32,
                              height: 32,
                            ),
                            Text(
                              "Entrar com Google",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
