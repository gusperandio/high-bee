import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:high_bee/infra/repository/cache_repository.dart';
import 'package:meu_sebrae/feature/main/controller/handler_authenticate_controller.dart';
import 'package:meu_sebrae/infra/repository/cache_repository.dart';
import 'package:meu_sebrae/util/cache.dart' as appcache;
// Importe seus serviços de cache, controllers, etc.
// import 'package:meu_app/repository/cache_repository.dart';
// import 'package:meu_app/features/authenticate/handler_authenticate_controller.dart';

// 1. O Notifier que vai gerenciar a lógica
class AuthNotifier extends AsyncNotifier<bool> {
  // O método build é responsável por criar o estado inicial.
  // Ele é chamado automaticamente e lida com a assincronicidade.
  @override
  Future<bool> build() async {
    // Toda a lógica de inicialização vai aqui.
    // Isso substitui o seu antigo `AuthenticationState.init()`.
    await _ssoSocialVerifyAndInit();

    // Após a verificação do SSO, lemos o estado final do cache.
    final bool? authenticatedState = await ref
        .read(cacheRepositoryProvider)
        .get<bool>('AuthenticationState');
    return authenticatedState ?? false;
  }

  // Lógica de verificação do SSO movida para dentro do provider.
  // A UI não precisa mais saber sobre isso.
  Future<void> _ssoSocialVerifyAndInit() async {
    try {
      final cache = ref.read(cacheRepositoryProvider);
      final token = await cache.get<String>('sebrae-autenticador-token');

      if (token == null) return;

      final controllerAction = ref.read(
        handlerAuthenticateControllerProvider.notifier,
      );
      final ssoSuccess = await controllerAction.socialAuthenticate(token);

      if (ssoSuccess) {
        // Se a autenticação SSO funcionou, atualizamos o estado e o cache.
        await cache.set('AuthenticationState', true, addDays: 1);
      }
    } catch (e) {
      print('Falha ao autenticar via login social na inicialização: $e');
    }
  }

  Future<void> login() async {
    // Coloca o estado como 'loading' enquanto a operação assíncrona ocorre.
    state = const AsyncValue.loading();
    // Usa AsyncValue.guard para tratar sucesso e erro automaticamente.
    state = await AsyncValue.guard(() async {
      await ref
          .read(cacheRepositoryProvider)
          .set('AuthenticationState', true, addDays: 1);
      return true;
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await appcache.Cache.set('AuthenticationState', false, addDays: 1);
      await appcache.Cache.clear();
      return false;
    });
  }
}

// 2. O Provider global que será usado na UI
final authProvider = AsyncNotifierProvider<AuthNotifier, bool>(() {
  return AuthNotifier();
});

// Supondo que você tenha esses providers definidos em algum lugar
// final cacheRepositoryProvider = Provider<CacheRepository>((ref) => CacheRepository());
// final handlerAuthenticateControllerProvider = ...
