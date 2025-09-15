import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/infra/models/datas/strain.dart';
import 'package:high_bee/viewmodel/strain/strain_view_model.dart';
import 'package:provider/provider.dart';

class StrainPage extends StatefulWidget {
  const StrainPage({super.key});

  @override
  StrainPageState createState() => StrainPageState();
}

class StrainPageState extends State<StrainPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StrainViewModel>().loadSavedStrains();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StrainViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: Loading(size: 140));
        }

        if (viewModel.strains.isEmpty) {
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
                        "Não encontramos nenhuma strain",
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
          body: AnimationLimiter(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: List.generate(viewModel.strains.length, (
                          index,
                        ) {
                          if (index.isEven) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 675),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: ScaleAnimation(
                                  child: _buildStrainCard(
                                    viewModel.strains[index],
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
                    Expanded(
                      child: Column(
                        children: List.generate(viewModel.strains.length, (
                          index,
                        ) {
                          if (index.isOdd) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 675),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: ScaleAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: _buildStrainCard(
                                      viewModel.strains[index],
                                    ),
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
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStrainCard(StrainModel strain) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: strain.photo,
            imageBuilder:
                (context, imageProvider) => ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    strain.photo,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
            placeholder:
                (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: PrimaryColors.carvaoColor,
                  ),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strain.nome,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(strain.desc, style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildIconText(Icons.local_florist, '${strain.thc}% THC'),
                    _buildIconText(
                      Icons.wb_sunny,
                      'Indoor: ${strain.rendIndoor}g',
                    ),
                    _buildIconText(
                      Icons.park,
                      'Outdoor: ${strain.rendOutdoor}g',
                    ),
                    if (strain.hibrida) _buildIconText(Icons.grass, 'Híbrida'),
                    if (strain.sativa)
                      _buildIconText(Icons.wb_cloudy, 'Sativa'),
                    if (strain.indica)
                      _buildIconText(Icons.landscape, 'Indica'),
                    if (strain.fotoperiodo)
                      _buildIconText(Icons.access_time, 'Fotoperíodo'),
                    if (strain.automatica)
                      _buildIconText(Icons.flash_on, 'Automática'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.green),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
