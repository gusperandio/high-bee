import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/dotted_card/dotted_card.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/post/image_post_view_model.dart';
import 'package:provider/provider.dart';

class ImagePostPage extends StatelessWidget {
  static const routeName = 'image_post';
  const ImagePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ImagePostViewModel>();

    return Consumer<ImagePostViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});

        return AppContainer(
          appBar: TopBar(title: "Título e Imagens"),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 35,
                    bottom: 15,
                  ),
                  color: PrimaryColors.claudeColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 20,
                    children: [
                      viewModel.selectedImage == null
                          ? DottedCard(
                            onTap: () => viewModel.pickImage(),
                            height: 140,
                            title: "Foto de capa",
                            description: "Obrigatório",
                            icon: SvgPicture.asset(
                              "assets/svg/image.svg",
                              colorFilter: ColorFilter.mode(
                                PrimaryColors.carvaoColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                          : GestureDetector(
                            onTap: () => viewModel.pickImage(),
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  8,
                                ), // Bordas arredondadas
                                image: DecorationImage(
                                  image: FileImage(viewModel.selectedImage!),
                                  fit:
                                      BoxFit
                                          .cover, // Preenche o container mantendo o aspecto
                                ),
                              ),
                            ),
                          ),

                      DottedCard(
                        onTap: () {},
                        height: 160,
                        title: "Foto de conteúdo 01",
                        description: "Obrigatório",
                        icon: SvgPicture.asset(
                          "assets/svg/image.svg",
                          colorFilter: ColorFilter.mode(
                            PrimaryColors.carvaoColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      DottedCard(
                        onTap: () {},
                        height: 160,
                        title: "Foto de conteúdo 02",
                        description: "Obrigatório",
                        icon: SvgPicture.asset(
                          "assets/svg/image.svg",
                          colorFilter: ColorFilter.mode(
                            PrimaryColors.carvaoColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      DottedCard(
                        onTap: () {},
                        height: 160,
                        title: "Foto de conteúdo 03",
                        description: "Obrigatório",
                        icon: SvgPicture.asset(
                          "assets/svg/image.svg",
                          colorFilter: ColorFilter.mode(
                            PrimaryColors.carvaoColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
