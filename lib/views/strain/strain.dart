import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/models/datas/strain.dart';

class StrainPage extends StatefulWidget {
  const StrainPage({super.key});

  @override
  StrainPageState createState() => StrainPageState();
}

class StrainPageState extends State<StrainPage> {
  late Future<List<StrainModel>> strainsFuture;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    DefaultTextStyle.of(context).style.copyWith(fontFamily: 'Nunito');
  }

  @override
  void initState() {
    super.initState();
    strainsFuture = fetchStrains();
  }

  Future<List<StrainModel>> fetchStrains() async {
    await Future.delayed(Duration(seconds: 2)); // simula carregamento

    return List.generate(
      10,
      (index) => StrainModel(
        nome: 'Strain #$index',
        desc: 'Descrição da strain número $index',
        thc: 22.5,
        combinacao: ['Amnesia', 'Blue Dream'],
        rendIndoor: 400,
        rendOutdoor: 600,
        efeitos: ['Relaxamento', 'Euforia'],
        photo:
            'https://blog.drcannabis.com.br/wp-content/uploads/2024/04/1094.jpg',
        hibrida: true,
        sativa: false,
        indica: true,
        fotoperiodo: true,
        automatica: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      backgroundColor: PrimaryColors.claudeColor,
      body: FutureBuilder<List<StrainModel>>(
        future: strainsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loading(size: 140));
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma strain encontrada'));
          }

          final strains = snapshot.data!;

          return AnimationLimiter(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Primeira coluna
                    Expanded(
                      child: Column(
                        children: List.generate(strains.length, (index) {
                          if (index.isEven) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 675),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: _buildStrainCard(strains[index]),
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
                        children: List.generate(strains.length, (index) {
                          if (index.isOdd) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 675),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: _buildStrainCard(strains[index]),
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
          );
        },
      ),
    );
  }

  Widget _buildStrainCard(StrainModel strain) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              strain.photo,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
