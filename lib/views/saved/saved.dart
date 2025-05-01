import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/viewmodel/news/news_view_model.dart';
import 'package:high_bee/viewmodel/saved/saved_view_model.dart';
import 'package:high_bee/views/news/news.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SavedViewModel>().loadSavedNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: Loading(size: 140));
        }

        if (viewModel.savedNews.isEmpty) {
          return AppContainer(
            resizeToAvoidBottomInset: false,
            backgroundColor: PrimaryColors.claudeColor,
            body: Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 250),
                      child: Text(
                        "Não encontramos nada salvo",
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 16,
                          color: PrimaryColors.carvaoColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 150,
                          child: Image.asset(
                            'assets/lottie/empty1.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return AppContainer(
          backgroundColor: PrimaryColors.claudeColor,
          body: AnimationLimiter(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: List.generate(viewModel.savedNews.length, (
                          index,
                        ) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 675),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FlipAnimation(
                                child: _buildSavedCard(
                                  viewModel.savedNews[index],
                                  context,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildSavedCard(NewsModel news, BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    child: ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(news.cape ?? '')),
      title: Text(
        news.title ?? 'Sem nome',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(news.tag ?? 'Tipo desconhecido'),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context)
            .push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 200),
                pageBuilder:
                    (_, animation, secondaryAnimation) =>
                        ChangeNotifierProvider(
                          create: (_) => NewsViewModel(),
                          child: NewsPage(news: news),
                        ),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            )
            .then((_) {
              final viewModel = context.read<SavedViewModel>();
              viewModel.loadSavedNews();
            });
      },
    ),
  );
}
