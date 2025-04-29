import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/buttons/button_circle.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/training/training_view_model.dart';
import 'package:high_bee/views/post/post.dart';
import 'package:provider/provider.dart';

class TrainingPage extends StatelessWidget {
  static const routeName = 'training';
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingViewModel>(
      builder: (context, viewModel, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});

        return AppContainer(
          body: Stack(
            children: [
              CarouselSlider(
                items: viewModel.pages,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    viewModel.setCurrentIndex(index);
                  },
                ),
                carouselController: viewModel.carouselController,
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
                          viewModel.pages.asMap().entries.map((entry) {
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
                                    viewModel.currentIndex == entry.key
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
                        if (viewModel.currentIndex > 0)
                          ButtonCircle.black(
                            onPressed:
                                () =>
                                    viewModel.carouselController.previousPage(),
                            content: SvgPicture.asset(
                              'assets/svg/chevron-left.svg',
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        if (viewModel.currentIndex !=
                            (viewModel.pages.length - 1))
                          ButtonCircle.black(
                            onPressed:
                                () => viewModel.carouselController.nextPage(),
                            content: SvgPicture.asset(
                              'assets/svg/chevron-right.svg',
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        if (viewModel.currentIndex ==
                            (viewModel.pages.length - 1))
                          ButtonCircle.black(
                            onPressed: () async {
                              await viewModel.youAreTrained();
                              MSNavigate.toSpecific(
                                context,
                                PostPage.routeName,
                              );
                            },
                            content: Text(
                              "Feito",
                              style: const TextStyle(
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
      },
    );
  }
}
