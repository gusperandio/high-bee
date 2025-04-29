import 'package:animations/animations.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/viewmodel/home/home_view_model.dart';
import 'package:high_bee/viewmodel/news/news_view_model.dart';
import 'package:high_bee/viewmodel/post/image_post_view_model.dart';
import 'package:high_bee/views/news/news.dart';
import 'package:high_bee/views/post/images_post.dart';
import 'package:provider/provider.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() { 
      final viewModel = context.read<HomeViewModel>();
      viewModel.fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final newsList = viewModel.news;
        final isLoading = viewModel.isLoading;

        if (isLoading) {
          return const Center(child: Loading(size: 140));
        }

        final myContent =
            newsList
                .map(
                  (news) => Padding(
                    padding: const EdgeInsets.only(left: 10, right: 25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white,
                        width: 250,
                        height: 400,
                        child: Stack(
                          children: [ 
                            Positioned.fill(
                              child: Image.network(
                                news.cape ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black87,
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              right: 15,
                              bottom: 15,
                              child: Text(
                                "Cannabis e reumatismo: uma nova perspectiva para o tratamento",
                                style: const TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList();

        return AppContainer(
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (viewModel.myBackground != null)
                      viewModel.myBackground!.contains("assets/images")
                          ? Image.asset(
                            viewModel.myBackground!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            filterQuality: FilterQuality.low,
                          ).blurred(
                            blur: 10,
                            colorOpacity: 0.1,
                            overlay: Container(color: Colors.black12),
                          )
                          : Image.network(
                            viewModel.myBackground!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            filterQuality: FilterQuality.low,
                          ).blurred(
                            blur: 10,
                            colorOpacity: 0.1,
                            overlay: Container(color: Colors.black12),
                          ),
                    Column(
                      children: [
                        Expanded(
                          child:
                              newsList.isNotEmpty
                                  ? VerticalCardPager(
                                    titles: List.generate(
                                      myContent.length,
                                      (_) => "",
                                    ),
                                    images: myContent,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    onPageChanged: (page) async {
                                      if (page! % 1 == 0) {
                                        final index = page.toInt();
                                        final newBg = newsList[index].cape!;
                                        await precacheImage(
                                          NetworkImage(newBg),
                                          context,
                                        );
                                        setState(
                                          () => viewModel.myBackground = newBg,
                                        );
                                      }
                                    },
                                    onSelectedItem: (index) {
                                      final news = newsList[index];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (_) => ChangeNotifierProvider(
                                                create: (_) => NewsViewModel(),
                                                child: NewsPage(news: news),
                                              ),
                                        ),
                                      );
                                    },
                                    initialPage: 0,
                                    align: ALIGN.LEFT,
                                    physics: const ClampingScrollPhysics(),
                                  )
                                  : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                      ),
                                      child: Text(
                                        "Estamos sem contéudo hoje!",
                                        style: const TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: PrimaryColors.claudeColor,
                                        ),
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
