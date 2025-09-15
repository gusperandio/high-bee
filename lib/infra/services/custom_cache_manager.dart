import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

// Singleton para garantir que teremos apenas uma instância do nosso CacheManager
class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      // Onde a mágica acontece: usamos nosso FileService customizado
      fileService: HttpFileService(
        // Sobrescrevemos o httpClient para controlar o comportamento da requisição
        httpClient: _CustomHttpClient(),
      ),
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );
}

// Este é o nosso cliente HTTP customizado.
// A única coisa que ele faz de diferente é tratar o status code 404.
class _CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Adiciona um header para ajudar a identificar a requisição, se necessário
    request.headers['user-agent'] = 'flutter-app';

    final response = await _inner.send(request);

    // Se a imagem não for encontrada (404), em vez de lançar uma exceção,
    // nós retornamos um Stream vazio. O CachedNetworkImage interpretará
    // isso como um download falho e chamará o errorWidget, mas sem Crashlytics.
    if (response.statusCode == 404) {
      // Retorna uma resposta vazia e bem-sucedida (200) para o FileService
      // que então não conseguirá salvar um arquivo e falhará silenciosamente.
      // OU, de forma mais direta, podemos lançar uma exceção que o FileService espera.
      // O importante é não deixar a HttpException padrão vazar.
      // Lançar essa exceção específica é a forma mais limpa.
      throw HttpExceptionWithStatus(response.statusCode, 'Image not found on server', uri: request.url);
    }

    return response;
  }
}
