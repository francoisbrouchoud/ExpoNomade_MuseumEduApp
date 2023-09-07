import 'dart:collection';

import 'package:expo_nomade_mobile/bo/exposition.dart';
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

/// Class GlobalConstants contains all global constants used throughout the application.
class GlobalConstants {
  /// Height for SizeBox separating two buttons vertically.
  static const double multiButtonVerticalSpacing = 10.0;

  /// Default dimensions for icons displayed in the application.
  static const double iconsDefaultDimension = 24.0;

  /// Default dimensions for image displayed in the application.
  static const double imagesDefaultDimension = 232.0;

  /// Editor block top and bottom margin height.
  static const double blockTopBottomMarginHeight = 15.0;

  /// Label margin for custom form widgets containing multiple TextFormFields.
  static const double multiTFFLabelMargin = 20.0;

  /// TextFormField right margin for custom widgets where the TextFormField could be followed by an icon.
  static const double textFormFieldIconRightMargin = 50.0;

  /// Width for bottom border of the UnderLinedContainerWidget.
  static const double ulcBottomBorderWidth = 1.0;

  /// String representing an empty string, used to store translated fields in the database, even if the translation hasn't been input.
  static const String emptyString = "EMPTY";

  /// Minimal number of coordinates to enter for an event BO.
  static const int eventMinCoordinatesNb = 3;

  /// Application buttons vertical padding.
  static const double appBtnVertPadding = 10.0;

  /// Application buttons horizontal padding.
  static const double appBtnHorzPadding = 20.0;

  /// Gets now's DateTime formatted for database insert.
  static String getNowFormattedForDB() {
    final DateTime now = DateTime.now();
    return "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}";
  }
}
