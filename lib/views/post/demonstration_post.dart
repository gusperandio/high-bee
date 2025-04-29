import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart'
    show Loading;
import 'package:high_bee/components/widgets/tags/tag.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/post/demonstration_view_model.dart';
import 'package:provider/provider.dart';

class DemonstrationPostPage extends StatefulWidget {
  static const routeName = 'demonstration';
  const DemonstrationPostPage({super.key});

  @override
  State<DemonstrationPostPage> createState() => _DemonstrationPostPageState();
}

class _DemonstrationPostPageState extends State<DemonstrationPostPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DemonstrationViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.isLoading && !viewModel.isDialogVisible) {
            viewModel.isDialogVisible = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: Loading(size: 120)),
            );
          }

          if (!viewModel.isLoading && viewModel.isDialogVisible) {
            viewModel.isDialogVisible = false;
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (viewModel.errorMessage != null) {
            Toast.show(
              context,
              viewModel.errorMessage!,
              variant: Variant.danger,
            );
            viewModel.errorMessage = null;
          }

          if (viewModel.isValid) {
            MSNavigate.toRoot(context);
          }
        });

        if (viewModel.isLoading || viewModel.news == null) {
          return const SizedBox.shrink();
        }

        final news = viewModel.news!;
        final paragraphs = viewModel.paragraphs;

        int breakPoint = (paragraphs.length / 2).ceil();

        return AppContainer(
          backgroundColor: PrimaryColors.claudeColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.saveMyNews();
            },
            backgroundColor: SecondaryColors.success,
            child: SvgPicture.asset(
              "assets/svg/book-up-2.svg",
              height: 28,
              width: 28,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          appBar: TopBar(title: "Demonstração"),
          body: SingleChildScrollView(
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 32,
                    bottom: 12,
                  ),
                  child: Text(
                    news.title ?? '',
                    style: TextStyle(
                      fontFamily: news.font,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                      height: 1.3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Tag.blackHigh(title: news.tag!),
                ),

                Container(
                  height: 160,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(File(news.cape!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      for (var paragraph in paragraphs.take(breakPoint))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            paragraph,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: news.font,
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (news.photo1 != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    height: 160,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(File(news.photo1!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (news.photo1desc != null && news.photo1desc != "")
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0, top: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "(${news.photo1desc})",
                          style: TextStyle(
                            fontFamily: news.font,
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                ],

                const SizedBox(height: 24),
 
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      for (var paragraph in paragraphs.skip(breakPoint))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            paragraph,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: news.font,
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
