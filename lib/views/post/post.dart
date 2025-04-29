import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/dropdown/dropdown.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/util/field_validator.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/post/post_view_model.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:high_bee/views/post/widgets/discard.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  static const routeName = 'post';
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostViewModel>();

    return Consumer<PostViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!viewModel.isFocused) {
            FocusScope.of(context).requestFocus(viewModel.focusNode);
            viewModel.isFocused = true;
          }

          if (viewModel.isValid) {
            FocusScope.of(context).unfocus();
            viewModel.isValid = false;
            MSNavigate.toName(context, ImagePostPage.routeName);
          }
        });

        return PopScope<Object?>(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }

            FocusScope.of(context).unfocus();

            if (viewModel.controllerTextReady.text.isNotEmpty) {
              showDialog(
                context: context,
                builder:
                    (context) => DiscardDialog(
                      onTapDiscard: () {
                        viewModel.cache.remove("post");
                        Future.delayed(const Duration(milliseconds: 100), () {
                          MSNavigate.toRoot(context);
                        });
                      },
                      onTap: viewModel.saveContent,
                    ),
              );
            }

            if (viewModel.controllerTextReady.text.isEmpty) {
              Future.delayed(const Duration(milliseconds: 300), () {
                MSNavigate.toRoot(context);
              });
            }
          },
          child: AppContainer(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.saveContent();
              },
              backgroundColor: const Color(0xFF000000),
              child: SvgPicture.asset(
                "assets/svg/chevron-right.svg",
                height: 32,
                width: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            appBar: TopBar(
              title: "Conteúdo",
              onTap: () {
                FocusScope.of(context).unfocus();

                if (viewModel.controllerTextReady.text.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder:
                        (context) => DiscardDialog(
                          onTapDiscard: () {
                            viewModel.cache.remove("post");
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                MSNavigate.toRoot(context);
                              },
                            );
                          },
                          onTap: viewModel.saveContent,
                        ),
                  );
                }

                if (viewModel.controllerTextReady.text.isEmpty) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    MSNavigate.toRoot(context);
                  });
                }
              },
            ),
            body: KeyboardDismissOnTap(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          color: PrimaryColors.claudeColor,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 20,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12,
                                        top: 24,
                                      ),
                                      child: DropdownCustom.def(
                                        selected: viewModel.font,
                                        items: ["Georgia", "Nunito"],
                                        size: 140,
                                        onChanged: (value) {
                                          viewModel.setFont(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Form(
                                    key: viewModel.formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      spacing: 0,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                scrollController:
                                                    viewModel.scrollController,
                                                maxLength:
                                                    viewModel.maxNumCharacters,
                                                focusNode: viewModel.focusNode,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onChanged: (value) {
                                                  viewModel
                                                      .atualizarLinhasDoParagrafo(
                                                        value
                                                            .trim()
                                                            .split(
                                                              RegExp(r'\s+'),
                                                            )
                                                            .length,
                                                      );
                                                  viewModel.setNumCharacters(
                                                    value.length,
                                                  );
                                                },
                                                style: TextStyle(
                                                  color:
                                                      PrimaryColors.carvaoColor,
                                                  fontFamily: viewModel.font,
                                                  fontSize: 18,
                                                ),
                                                minLines: viewModel.linhas,
                                                maxLines: viewModel.linhas,
                                                controller:
                                                    viewModel
                                                        .controllerTextReady,
                                                cursorWidth: 1,
                                                cursorColor:
                                                    PrimaryColors.carvaoColor,
                                                textAlign: TextAlign.start,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: InputDecoration(
                                                  floatingLabelStyle: TextStyle(
                                                    color: Colors.black26,
                                                    fontFamily: viewModel.font,
                                                    fontSize: 18,
                                                  ),
                                                  labelText:
                                                      'O que irá publicar hoje?',
                                                  labelStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: viewModel.font,
                                                    fontSize: 20,
                                                  ),
                                                  alignLabelWithHint: true,
                                                  border:
                                                      InputBorder
                                                          .none, // Sem borda normal
                                                  enabledBorder:
                                                      InputBorder
                                                          .none, // Sem borda quando desabilitado
                                                  focusedBorder:
                                                      InputBorder
                                                          .none, // Sem borda quando focado
                                                  disabledBorder:
                                                      InputBorder.none,
                                                ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator:
                                                    (value) =>
                                                        FieldValidator.validateArgumentNews(
                                                          value,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        const Divider(
                          height: 1,
                          color: PrimaryColors.carvaoColor,
                        ),

                        Container(
                          color: PrimaryColors.highBeeColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      "${viewModel.numCharacters} / 6000",
                                      style: const TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 42,
                                      width: 42,
                                      child: CircularProgressIndicator(
                                        padding: EdgeInsets.all(10),
                                        value: viewModel.progress,
                                        strokeWidth: 4,
                                        backgroundColor: Colors.grey.shade300,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              viewModel.progress < 1.0
                                                  ? PrimaryColors.carvaoColor
                                                  : SecondaryColors.danger,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 4,
                                  children: [
                                    Button.black(
                                      onPressed: () {
                                        viewModel.adicionarParagrafo();
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(viewModel.focusNode);
                                      },
                                      title: "Parágrafo",
                                      endContent: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/svg/pilcrow.svg",
                                          height: 12,
                                          width: 12,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Button.danger(
                                      onPressed: () => viewModel.limpar(),
                                      title: "Limpar",
                                      endContent: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/svg/eraser.svg",
                                          height: 14,
                                          width: 14,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Button.success(
                                      onPressed: () {
                                        viewModel.colarTexto(true);
                                      },
                                      title: "Colar",
                                      endContent: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8.0,
                                        ),
                                        child: SvgPicture.asset(
                                          "assets/svg/copy.svg",
                                          height: 12,
                                          width: 12,
                                          colorFilter: const ColorFilter.mode(
                                            Colors.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
