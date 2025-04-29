import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/dotted_card/dotted_card.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/post/image_post_view_model.dart';
import 'package:high_bee/views/post/demonstration_post.dart';
import 'package:high_bee/views/post/widgets/selected_tag.dart';
import 'package:provider/provider.dart';

class ImagePostPage extends StatelessWidget {
  static const routeName = 'image_post';
  const ImagePostPage({super.key});

  @override
  Widget build(BuildContext context) {  
    return Consumer<ImagePostViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.errorMessage != null) {
            Toast.show(context, viewModel.errorMessage!, variant: Variant.danger);
            viewModel.errorMessage = null;
          }

          if (viewModel.isValid) {
            FocusScope.of(context).unfocus();
            viewModel.isValid = false;
            MSNavigate.toName(
              context,
              DemonstrationPostPage.routeName,
            );
          }
        });

        return AppContainer(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.validate();
            },
            backgroundColor: const Color(0xFF000000),
            child: SvgPicture.asset(
              "assets/svg/book-open-check.svg",
              height: 28,
              width: 28,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          appBar: TopBar(title: "Título e Imagens"),
          body: KeyboardDismissOnTap(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 6,
                              children: [
                                TextFormField(
                                  controller: viewModel.controllerTitle,
                                  cursorWidth: 1,
                                  cursorColor: PrimaryColors.carvaoColor,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
                                      color: PrimaryColors.carvaoColor,
                                    ),
                                    labelText: 'Título',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator:
                                      (value) =>
                                          FieldValidator.validateTitleNews(
                                            value,
                                          ),
                                ),
                                const SizedBox(height: 12),
                                RichText(
                                  text: TextSpan(
                                    text: 'Foto de Capa ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: PrimaryColors.carvaoColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '(obrigatório)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                viewModel.selectedCape == null
                                    ? DottedCard(
                                      onTap: () => viewModel.pickCape(),
                                      height: 160,
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
                                      onTap: () => viewModel.pickCape(),
                                      child: Container(
                                        height: 160,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),  
                                          image: DecorationImage(
                                            image: FileImage(
                                              viewModel.selectedCape!,
                                            ),
                                            fit:
                                                BoxFit
                                                    .cover,  
                                          ),
                                        ),
                                      ),
                                    ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Toque para selecionar",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Urbanist',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                RichText(
                                  text: TextSpan(
                                    text: 'Foto do conteúdo ',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: PrimaryColors.carvaoColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '(opcional)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: SecondaryColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                viewModel.selectedImage1 == null
                                    ? DottedCard(
                                      onTap: () => viewModel.pickImage(),
                                      height: 180,
                                      title: "Foto do conteúdo",
                                      description: "Opcional",
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
                                        height: 180,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),  
                                          image: DecorationImage(
                                            image: FileImage(
                                              viewModel.selectedImage1!,
                                            ),
                                            fit:
                                                BoxFit
                                                    .cover,  
                                          ),
                                        ),
                                      ),
                                    ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Toque para selecionar",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Urbanist',
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120),
                                  child: TextFormField(
                                    maxLines: 2,
                                    minLines: 2,
                                    controller: viewModel.controllerSubtitleImg,
                                    cursorWidth: 1,
                                    cursorColor: PrimaryColors.carvaoColor,
                                    decoration: InputDecoration(
                                      floatingLabelStyle: const TextStyle(
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                      labelText: 'Legenda (opcional)',
                                      labelStyle: TextStyle(
                                        color: PrimaryColors.carvaoColor,
                                        fontFamily: 'Urbanist',
                                        fontSize: 10,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: PrimaryColors.carvaoColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: PrimaryColors.carvaoColor,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                ValueListenableBuilder<String?>(
                                  valueListenable: viewModel.tagNotifier,
                                  builder: (context, tag, child) {
                                    return TagSelector(
                                      initialValue: tag,
                                      tags: viewModel.tags,
                                      onTagSelected: (selectedTag) {
                                        if (FocusScope.of(context).hasFocus) {
                                          FocusScope.of(context).unfocus();
                                        }
                                        viewModel.setTag(selectedTag);
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
