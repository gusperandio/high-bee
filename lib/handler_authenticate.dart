import 'package:flutter/material.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';
import 'package:high_bee/views/home.dart';
import 'package:high_bee/views/login.dart';

class HandlerAuthenticate extends StatelessWidget {
  static const routeName = '/';
  const HandlerAuthenticate({super.key});

  Widget _futureBuilder(BuildContext context) {
    return FutureBuilder(
      future: AuthenticationState.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Erro ao carregar autenticação')));
        }

        final authState = MSProvider.get<AuthenticationState>(context);

        if (authState.isAuthenticated) return HomePage(title: 'Home Page');

        return const LoginPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _futureBuilder(context);
  }
}
