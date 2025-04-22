import 'package:flutter/material.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/views/main_page.dart';
import 'package:high_bee/views/login/welcome.dart';

class HandlerAuthenticate extends StatelessWidget {
  static const routeName = '/';
  const HandlerAuthenticate({super.key});

  Widget _futureBuilder(BuildContext context) {
    return FutureBuilder(
      future: AuthenticationState.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: Loading(size: 160)));
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Erro ao carregar autenticação')),
          );
        }

        final authState = MSProvider.get<AuthenticationState>(context);

        if (authState.isAuthenticated) return MainPage();

        return const WelcomePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _futureBuilder(context);
  }
}
