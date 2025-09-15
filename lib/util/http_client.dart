import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future<http.Response> get(Uri url, {Map<String, String>? headers});
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<http.Response> postMultipart(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? fields, // Para campos de texto adicionais
    required String
    fileField, // O nome do campo do arquivo (ex: 'file' ou 'avatar')
    required String filePath, // O caminho do arquivo no dispositivo
  });
}

class HttpClient implements IHttpClient {
  final http.Client _client;

  HttpClient([http.Client? client]) : _client = client ?? http.Client();

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers, // mescla os valores existentes (se houver)
    };
    return _client.get(url, headers: headers);
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers, // mescla os valores existentes (se houver)
    };
    return _client.post(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers, // mescla os valores existentes (se houver)
    };
    return _client.put(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers, // mescla os valores existentes (se houver)
    };
    return _client.patch(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?headers, // mescla os valores existentes (se houver)
    };
    return _client.delete(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  @override
  Future<http.Response> postMultipart(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    required String fileField,
    required String filePath,
  }) async {
    // 1. Cria a requisição multipart
    final request = http.MultipartRequest('POST', url);

    // 2. Adiciona os headers. Note que NÃO forçamos 'Content-Type'.
    // A classe MultipartRequest fará isso por nós com a boundary correta.
    final defaultHeaders = {'Accept': 'application/json'};
    request.headers.addAll(defaultHeaders);
    if (headers != null) {
      request.headers.addAll(headers);
    }

    // 3. Adiciona os campos de texto, se houver
    if (fields != null) {
      request.fields.addAll(fields);
    }

    // 4. Adiciona o arquivo
    request.files.add(
      await http.MultipartFile.fromPath(
        fileField, // O nome do campo na API
        filePath, // O caminho do arquivo
      ),
    );

    // 5. Envia a requisição e obtém uma StreamedResponse
    final streamedResponse = await _client.send(request);

    // 6. Converte a StreamedResponse em uma http.Response para manter a consistência
    return http.Response.fromStream(streamedResponse);
  }
}
