import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:flutter/material.dart';

class DataNotifier extends ChangeNotifier {
  Exposition? _exposition;
  bool _isLogin = false;

  Exposition get exposition => _exposition!;
  bool get isLogin => _isLogin;

  /// Updates the current locale and notifies the listeners
  void setExposition(Exposition expo) {
    if (_exposition != expo) {
      _exposition = expo;
    }
  }

  void setIsLogin(bool isLogin) {
    if (_isLogin != isLogin) {
      _isLogin = isLogin;
      notifyListeners();
    }
  }

  void forceRelaod() {
    notifyListeners();
  }
}
