import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatusChecker {
  static Future<bool> isOffline() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.none);
  }
}
