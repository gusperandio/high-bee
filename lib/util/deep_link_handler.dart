import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:high_bee/util/cache.dart'; 

// NavigatorKey global — use no seu MaterialApp
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  factory DeepLinkHandler() => _instance;

  DeepLinkHandler._internal();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _sub;

  Future<void> init() async {
    try {
      // Captura deep link que abriu o app (caso estivesse fechado)
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleUri(initialUri);
      }

      // Captura links com app já aberto
      _sub = _appLinks.uriLinkStream.listen(
        (Uri uri) => _handleUri(uri),
        onError: (err) => throw Exception('Erro ao escutar deep link: $err'),
      );
    } catch (e) {
      throw Exception('Erro ao inicializar DeepLinkHandler: $e');
    }
  }

  void _handleUri(Uri uri) async {
    if (uri.scheme != 'meusebraeapp') return;

    switch (uri.host) {
      case 'auth-callback':
        final token = uri.queryParameters['sebrae_autenticador_token'];
        final providerAccessToken =
            uri.queryParameters['provider_access_token'];
        final loginMessageId = uri.queryParameters['login_message_id'];

        // Login social
        if (token != null) {
          await Cache.delete('sebrae-autenticador-token');
          await Cache.set<String>(
            'sebrae-autenticador-token',
            token,
            addYear: 1,
          );
        }

        // Primeiro acesso login social
        if (providerAccessToken != null && loginMessageId != null) {
          await Cache.delete('first-access-social-login');
          await Cache.set<Map<String, String>>('first-access-social-login', {
            'providerAccessToken': providerAccessToken,
            'loginMessageId': loginMessageId,
          }, addYear: 1);
        }

        goHome();
        break;
      case 'contents':
        final id = uri.queryParameters['id'];
        final type = uri.queryParameters['type'];

        if (id == null && type == null) {
          goHome();
          return;
        }

        if (type == "webstorie") {
          specificPage(type!);
          return;
        }

       
        break;
      case 'internal_page':
        final myPage = uri.queryParameters['page'];
        if (myPage == null) goHome();
        specificPage(myPage!);
        break;
      default:
        goHome();
        break;
    }
  }

  void goHome() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed('/');
    });
  }

  void specificPage(String namePage) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState?.pushNamed(namePage);
    });
  }

  void dispose() {
    _sub?.cancel();
  }
}
