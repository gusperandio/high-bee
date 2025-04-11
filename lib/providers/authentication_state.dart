import 'package:flutter/foundation.dart';
import 'package:high_bee/util/cache.dart';

class AuthenticationState extends ChangeNotifier {
  static bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  static Future init() async {
    bool? authenticatedState = Cache().getAuth();

    if (authenticatedState != null) {
      _isAuthenticated = authenticatedState;
    }
  }

  void login() async {
    bool? authenticatedState = Cache().getAuth();

    if (authenticatedState == null || authenticatedState == false) {
      await Cache().setAuth(true);
      _isAuthenticated = true;
    } else {
      _isAuthenticated = authenticatedState;
    }

    notifyListeners();
  }

  void logout() async {
    bool? authenticatedState = Cache().getAuth();

    if (authenticatedState == null) {
      await Cache().setAuth(false);
      _isAuthenticated = false;
    } else if (authenticatedState) {
      await Cache().setAuth(false);
      _isAuthenticated = false;
    } else {
      _isAuthenticated = authenticatedState;
    }

    notifyListeners();
  }
}
