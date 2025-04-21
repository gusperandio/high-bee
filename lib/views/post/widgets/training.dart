import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/bullet_point/bullet_point.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/buttons/button_circle.dart';
import 'package:high_bee/components/widgets/separator/separator.dart';
import 'package:high_bee/components/widgets/watermaker/watermaker.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?auto=format&fit=crop&w=1355&q=80',
];

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final List<Widget> _pages = [
    Container(
      color: PrimaryColors.highBeeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/marcadagua.png',
                width: 180,
                height: 140,
              ),
              SizedBox(height: 20),
              Text(
                "Vamos começar seu treinamento!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Aqui você compartilha, aprende e se conecta com conteúdos confiáveis sobre cannabis.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Vamos aprender sobre postar conteúdos!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              BulletPoint(text: 'Como é exibido títulos', sizeFont: 18),
              BulletPoint(text: 'Como é exibido a capa', sizeFont: 18),
              BulletPoint(text: 'Como fornecer o conteúdo', sizeFont: 18),
              BulletPoint(text: 'Escolha o estilo', sizeFont: 18),
              BulletPoint(text: 'Como é exibido todo o conteúdo', sizeFont: 18),
            ],
          ),
        ),
      ),
    ),
    Container(
      color: PrimaryColors.claudeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                "Título da publicação",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Formato de como é exibido o título da sua publicação",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SvgPicture.asset("assets/svg/rules/title_rule.svg", height: 340),
              const SizedBox(height: 15),
              BulletPoint(
                text: 'Não é permitido deixar sem título',
                sizeFont: 16,
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
      color: PrimaryColors.claudeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                "Fotos e Imagens",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Formato de como é exibido as imagens de \ncapa e cada publicação",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SvgPicture.asset("assets/svg/rules/cape_rule.svg", height: 340),
              BulletPoint(
                text: 'Não é permitido deixar sem capa',
                sizeFont: 16,
              ),
              BulletPoint(text: 'É opcional imagens adicionais', sizeFont: 16),
              BulletPoint(
                text: 'É possível adicionar legenda em cada foto adicionada',
                sizeFont: 16,
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
      color: PrimaryColors.claudeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                "Fornecendo conteúdo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Você pode utilizar o botão de colar o paragráfo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SvgPicture.asset("assets/svg/rules/copy_paste.svg", height: 165),
              Separator(
                color: Colors.black,
                content: const Text(
                  "Ou tentar digitar",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                size: 1,
              ),
              SvgPicture.asset("assets/svg/rules/keyboards.svg", height: 100),
              BulletPoint(
                text: 'Pode adicionar muitos parágrafos',
                sizeFont: 16,
              ),
              BulletPoint(
                text: 'É obrigatório informar pelo menos o primeiro parágrafo',
                sizeFont: 16,
              ),
              BulletPoint(
                text: 'Antes de postar, sempre verifique as regras!',
                sizeFont: 16,
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
      color: PrimaryColors.claudeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                "Escolha seu estilo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Escolha o tipo de fonte para trazer aquele AR",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "MAIS SÉRIO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Georgia',
                ),
              ),
              Image.asset(
                "assets/images/smile.png",
                fit: BoxFit.cover,
                width: 150,
                height: 110,
              ),
              Separator(
                color: Colors.black,
                content: const Text(
                  "OU",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                size: 1,
              ),
              Text(
                "MAIS DIVERTIDO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Nunito',
                ),
              ),
              Image.asset(
                "assets/images/stoner.png",
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    ),
    Container(
      color: PrimaryColors.claudeColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            spacing: 12,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text(
                "Seu conteúdo final",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "A ordem como é exibido também segue no mesmo formato na qual é preenchido",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: PrimaryColors.carvaoColor,
                  fontFamily: 'Urbanist',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SvgPicture.asset("assets/svg/rules/all_content.svg", height: 340),
              const SizedBox(height: 15),
              BulletPoint(text: 'LEIA AS REGRAS!', sizeFont: 16),
              BulletPoint(text: 'Divirta-se', sizeFont: 16),
            ],
          ),
        ),
      ),
    ),
  ];

  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return AppContainer(
      body: Stack(
        children: [
          CarouselSlider(
            items: _pages,
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            carouselController: _carouselController,
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      _pages.asMap().entries.map((entry) {
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentIndex == entry.key
                                    ? PrimaryColors.carvaoColor
                                    : PrimaryColors.darkGrayColor,
                          ),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (_currentIndex > 0)
                      ButtonCircle.black(
                        onPressed: () => _carouselController.previousPage(),
                        content: SvgPicture.asset(
                          'assets/svg/chevron-left.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    if (_currentIndex != (_pages.length - 1))
                      ButtonCircle.black(
                        onPressed: () => _carouselController.nextPage(),
                        content: SvgPicture.asset(
                          'assets/svg/chevron-right.svg',
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    if (_currentIndex == (_pages.length - 1))
                      ButtonCircle.black(
                        onPressed: () => _carouselController.nextPage(),
                        content: Text(
                          "Feito",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
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
  }
}
