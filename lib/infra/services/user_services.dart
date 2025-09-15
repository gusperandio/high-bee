import 'dart:convert';
import 'dart:io';
import 'package:high_bee/domain/entities/user.dart'; 

class UserServices {
  final HttpClient _httpClient = HttpClient();

  Future<User> get() async {
    try {
      final url = Uri.parse("${Constants.cmsUrl}profiles/login");
      final tokens = await Token.get();
      final response = await _httpClient.get(
        url,
        headers: {'Authorization': 'Bearer ${tokens.cmsToken}', 'APP_KEY': Constants.appKey},
      );
      if (response.statusCode == 200) {
        final user = jsonDecode(response.body)['usuario'];
        return User.fromJson(user);
      }
      throw Exception('Failed to load user data: ${response.statusCode}');
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<int?> getIdPJMainBond(int? codAgente) async {
    try {
      final tokens = await Token.get();
      final url = Uri.parse("${Constants.crmApi}agente/$codAgente/vinculo");

      final response = await _httpClient.get(
        url,
        headers: {'Authorization': tokens.sebraeServicesToken, 'APP_KEY': Constants.appKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> vinculos = jsonDecode(response.body);
        int? codigoAgentePJ;
        DateTime? dateCompare;
        for (var item in vinculos) {
          final String? dataAtzStr = item['dataAtz'];
          final String? dataIncStr = item['dataInc'];
          final int? codigo = item['codigo'];

          if (dateCompare == null) {
            // Primeira iteração define a data inicial
            dateCompare =
                (dataAtzStr != null && dataAtzStr.isNotEmpty)
                    ? DateVO(dataAtzStr).value
                    : DateVO(dataIncStr ?? '').value;
            codigoAgentePJ = codigo ?? 0;
            continue;
          }

          if (dataAtzStr != null && dataAtzStr.isNotEmpty) {
            final DateTime dataAtz = DateVO(dataAtzStr).value;
            if (dataAtz.isAfter(dateCompare)) {
              dateCompare = dataAtz;
              codigoAgentePJ = codigo ?? 0;
            }
            continue;
          }

          if ((dataAtzStr == null || dataAtzStr.isEmpty) && dataIncStr != null && dataIncStr.isNotEmpty) {
            final DateTime? dataInc = DateTime.tryParse(dataIncStr);
            if (dataInc != null && dataInc.isAfter(dateCompare)) {
              dateCompare = dataInc;
              codigoAgentePJ = codigo ?? 0;
            }
          }
        }

        return codigoAgentePJ;
      }

      return null;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
