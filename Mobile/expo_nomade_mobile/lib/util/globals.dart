import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:flutter/material.dart';

class ExpositionNotifier extends ChangeNotifier {
  Exposition? _exposition;

  Exposition get exposition => _exposition!;

  /// Updates the current locale and notifies the listeners
  void setExposition(Exposition expo) {
    if (_exposition != expo) {
      _exposition = expo;
    }
  }

  void forceRelaod() {
    notifyListeners();
  }
}

class LoginNotifier extends ChangeNotifier {
  bool _isLogin = false;

  bool get isLogin => _isLogin;

  void setIsLogin(bool isLogin) {
    if (_isLogin != isLogin) {
      _isLogin = isLogin;
      notifyListeners();
    }
  }
}
