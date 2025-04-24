import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/viewmodel/loading/loading_view_model.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  static const String routeName = 'loading';
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  AuthenticationState? authState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    return Consumer<LoadingViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (vm.started) {
            vm.initPage();
          }

          if (vm.finished) {
            Future.delayed(const Duration(seconds: 3), () {
              if (context.mounted) {
                authState.login();
                MSNavigate.toRoot(context);
              }
            });
          }
        });

        return AppContainer(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Loading(size: 160),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Seja',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 220,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontFamily: 'Urbanist',
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: true,
                              repeatForever: true,
                              animatedTexts: [
                                RotateAnimatedText(
                                  'Bem-vindo',
                                  transitionHeight: 120,
                                  alignment: Alignment.centerLeft,
                                ),
                                RotateAnimatedText(
                                  'Legal',
                                  transitionHeight: 120,
                                  alignment: Alignment.centerLeft,
                                ),
                                RotateAnimatedText(
                                  'Informativo',
                                  transitionHeight: 120,
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
