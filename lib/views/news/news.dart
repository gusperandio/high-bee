import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button_circle.dart';
import 'package:high_bee/components/widgets/buttons/button_outline.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/infra/models/datas/news.dart';
import 'package:high_bee/viewmodel/news/news_view_model.dart';
import 'package:high_bee/views/news/widgets/dialog_report.dart';
import 'package:high_bee/views/profile/widgets/cannabis_stage.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  static const routeName = 'news';
  final NewsModel news;

  const NewsPage({super.key, required this.news});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<NewsViewModel>(context, listen: false);
      viewModel.initialize(widget.news);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.itsMeBaby) {
            Toast.show(
              context,
              "Você não pode se auto denunciar",
              variant: Variant.danger,
            );
            viewModel.itsMeBaby = false;
          }

          if (viewModel.isReported) {
            Toast.show(
              context,
              "Denúncia enviada! Agradecemos o seu apoio!",
              variant: Variant.success,
            );
            viewModel.isReported = false;
          }
        });
        return AppContainer(
          appBar: TopBar(),
          backgroundColor: PrimaryColors.claudeColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                spacing: 18,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.news.title ?? '',
                    style: TextStyle(
                      fontFamily: widget.news.font,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222222),
                      height: 1.3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Tag.blackHigh(title: widget.news.tag!),
                      if (widget.news.minReads! > 0)
                        Text(
                          "${widget.news.minReads} min de leitura",
                          style: TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.news.cape!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      for (var paragraph in viewModel.paragraphs.take(
                        viewModel.breakPoint,
                      ))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            paragraph,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: widget.news.font,
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (widget.news.photo1 != null) ...[
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.news.photo1!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (widget.news.photo1desc != null)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "(${widget.news.photo1desc})",
                          style: TextStyle(
                            fontFamily: widget.news.font,
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        for (var paragraph in viewModel.paragraphs.skip(
                          viewModel.breakPoint,
                        ))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              paragraph,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: widget.news.font,
                                fontSize: 16,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonCircle.danger(
                          content: SvgPicture.asset(
                            'assets/svg/triangle-alert.svg',
                            width: 32,
                            height: 32,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () async {
                            final selectedReason = await showDialog<String>(
                              context: context,
                              builder:
                                  (_) => DialogReport(items: viewModel.reports),
                            );
                            if (selectedReason != null) {
                              viewModel.startReport(
                                selectedReason,
                                widget.news,
                              );
                            }
                          },
                        ),
                        !viewModel.isSaved
                            ? ButtonCircle.def(
                              content: SvgPicture.asset(
                                'assets/svg/bookmark.svg',
                                width: 32,
                                height: 32,
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {
                                viewModel.saveNews(widget.news);
                              },
                            )
                            : ButtonCircle.success(
                              content: SvgPicture.asset(
                                'assets/svg/bookmark-check.svg',
                                width: 32,
                                height: 32,
                                colorFilter: ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onPressed: () {
                                viewModel.removeNews(widget.news.id!);
                              },
                            ),
                      ],
                    ),
                    ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/icon_launcher.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text(
                        widget.news.user!.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      subtitle: Text(
                        widget.news.user!.intention,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
