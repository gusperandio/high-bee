import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatusChecker {
  /// Retorna `true` se não houver conexão com a internet.
  /// Retorna `false` se houver qualquer tipo de conexão.
  static Future<bool> isOffline() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.none);
  }
}
