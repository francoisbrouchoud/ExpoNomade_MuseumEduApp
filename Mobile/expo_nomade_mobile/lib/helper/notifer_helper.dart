import 'dart:collection';

import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:flutter/material.dart';

import '../bo/expo_name.dart';

class ExpositionNotifier extends ChangeNotifier {
  Exposition? _exposition;
  Map<String, ExpoName>? _exposititons;

  Exposition get exposition => _exposition!;

  Map<String, ExpoName> get expositions => _exposititons ?? HashMap();

  /// Updates the current locale and notifies the listeners
  void setExposition(Exposition expo) {
    if (_exposition != expo) {
      _exposition = expo;
    }
  }

  void setExpositions(Map<String, ExpoName> expos) {
    if (_exposititons != expos) {
      _exposititons = expos;
    }
  }

  void forceRelaod() {
    notifyListeners();
  }
}

/// Notifier class for museums
class MuseumNotifier extends ChangeNotifier {
  Map<String, Museum>? _museums;

  Map<String, Museum> get museums => _museums ?? HashMap();

  /// Sets the museums
  void setMuseums(Map<String, Museum>? museums) {
    _museums = museums;
  }

  /// Notifies all the listeners
  void forceReload() {
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
