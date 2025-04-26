import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/accordions/accordion.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/components/widgets/sticker/sticker.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/viewmodel/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    final authState = MSProvider.get<AuthenticationState>(context);

    return Consumer<ProfileViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/background_profile.png',
              ), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? 64
                              : 32,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                child: SvgPicture.network(
                                  "https://api.dicebear.com/9.x/thumbs/svg?seed=Jack",
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Tag.defLow(title: "Semente 🌱"),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  authState.logout();
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/log-out.svg",
                                  colorFilter: ColorFilter.mode(
                                    SecondaryColors.danger,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Gustavo Sperandio',
                            style: const TextStyle(
                              color: PrimaryColors.carvaoColor,
                              fontSize: 24,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: PrimaryColors.carvaoColor,
                          ),
                          Text(
                            'Tecnologia - Desenvolvedor(a) de software',
                            style: const TextStyle(
                              color: PrimaryColors.carvaoColor,
                              fontSize: 18,
                              fontFamily: 'Urbanist',
                              fontStyle: FontStyle.italic,
                            ),
                          ),

                          Wrap(
                            runSpacing: 6,
                            spacing: 8,
                            children: [
                              Tag.infoHigh(title: "Publicações: 15"),
                              Tag.successHigh(title: "Sticker: 6"),
                              Tag.dangerHigh(title: "Denúncias: 1"),
                            ],
                          ),
                        ],
                      ),
                    ).frosted(
                      blur: 3,
                      frostOpacity: 0.6,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Accordion(
                      title: "Stickers",
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          runSpacing: 6,
                          spacing: 8,
                          children: [
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fdoctor.png?alt=media&token=60a45a59-7fd7-489d-a3a7-f1c439fdf959",
                              description: "Doctor",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fgorila.png?alt=media&token=2153e05f-66d9-41e1-82ff-b8fd91e75cd4",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fhoney-bee.png?alt=media&token=e092b9fa-2a02-4dd8-a891-dbd8a0474785",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fone-hundred.png?alt=media&token=c5736a14-3eea-465b-9825-f6e058d0b637",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Freggae.png?alt=media&token=4feba777-8158-491d-bdef-1685678a5e8a",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fsurf.png?alt=media&token=3750f537-9ab4-4612-a52b-33f7a0f31489",
                              description: "Cadastro",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Accordion(
                      background: PrimaryColors.offWhiteColor,
                      title: "Prêmios",
                      content: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          runSpacing: 6,
                          spacing: 8,
                          children: [
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fdoctor.png?alt=media&token=60a45a59-7fd7-489d-a3a7-f1c439fdf959",
                              description: "Doctor",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fgorila.png?alt=media&token=2153e05f-66d9-41e1-82ff-b8fd91e75cd4",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fhoney-bee.png?alt=media&token=e092b9fa-2a02-4dd8-a891-dbd8a0474785",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fone-hundred.png?alt=media&token=c5736a14-3eea-465b-9825-f6e058d0b637",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Freggae.png?alt=media&token=4feba777-8158-491d-bdef-1685678a5e8a",
                              description: "Cadastro",
                            ),
                            Sticker(
                              imageUrl:
                                  "https://firebasestorage.googleapis.com/v0/b/high-bee-3c65d.firebasestorage.app/o/stickers%2Fsurf.png?alt=media&token=3750f537-9ab4-4612-a52b-33f7a0f31489",
                              description: "Cadastro",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Button.def(
                        title: "+ Sticker",
                        onPressed: () {
                          // Add your edit profile logic here
                        },
                        fontColor: PrimaryColors.carvaoColor,
                      ),
                      Button.success(
                        title: "+ Competição",
                        onPressed: () {
                          // Add your logout logic here
                        },
                      ),
                    ],
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
