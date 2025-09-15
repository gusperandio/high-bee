import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/infra/providers/auth_provider.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:high_bee/views/main_page.dart';
import 'package:high_bee/views/wecolme/welcome.dart'; 

class HandlerAuthenticate extends ConsumerWidget {
  static const routeName = '/';

  const HandlerAuthenticate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // "Ouvimos" o estado do nosso novo provider.
    final authState = ref.watch(authProvider);

    // O método .when do Riverpod é o substituto perfeito e mais limpo
    // para o FutureBuilder.
    return authState.when(
      // Estado de sucesso: o Future foi concluído.
      data: (isAuthenticated) {
        // A UI simplesmente reage ao estado booleano.
        // Toda a lógica complexa está no AuthNotifier.
        if (isAuthenticated) {
          return MainPage(); // Usuário autenticado
        } else {
          // NOTA: A lógica do `firstAccessSocialLogin` que redirecionava
          // para `BindSocialAuthenticatePage` também deveria ser movida para
          // um provider ou ser gerenciada pelo seu sistema de rotas (ex: GoRouter).
          // Por simplicidade aqui, vamos direto para a página de login.
          return const WelcomePage(); // Usuário não autenticado
        }
      },
      // Estado de carregamento inicial.
      loading:
          () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: PrimaryColors.carvaoColor,
              ),
            ),
          ),
      // Estado de erro.
      error:
          (error, stackTrace) => Scaffold(
            body: Center(
              child: Text(
                'Erro ao carregar autenticação: $error',
                style: const TextStyle(
                  fontFamily: 'Figtree',
                  color: PrimaryColors.carvaoColor,
                  fontSize: 12,
                ),
              ),
            ),
          ),
    );
  }
}
