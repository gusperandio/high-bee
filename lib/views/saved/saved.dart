import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/models/datas/news.dart';
import 'package:high_bee/viewmodel/saved/saved_view_model.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SavedViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: Loading(size: 140));
        }

        if (viewModel.savedNews.isEmpty) {
          return Center(child: Text('Nenhuma strain encontrada'));
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
                          if (index.isEven) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 675),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FlipAnimation(
                                  child: _buildSavedCard(
                                    viewModel.savedNews[index],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
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

Widget _buildSavedCard(NewsModel news) {
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
      onTap: () {},
    ),
  );
}
