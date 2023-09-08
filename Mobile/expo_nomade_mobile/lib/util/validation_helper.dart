import 'package:expo_nomade_mobile/bo/quiz_question.dart';
import 'package:expo_nomade_mobile/util/globals.dart';

import 'multilingual_string.dart';
import 'package:latlong2/latlong.dart';

/// Class ValidationHelper provides methods for data validation.
class ValidationHelper {
  /// Checks if a string is a valid e-mail address.
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegex.hasMatch(email);
  }

  /// Checks if a string is an empty string placeholder used to validate multilingual elements in the database.
  static bool isEmptyString(String string) {
    return string.trim().isEmpty ||
        string.trim() == GlobalConstants.emptyString;
  }

  /// Checks if a MultilingualString is empty.
  static bool isEmptyMultiLingString(MultilingualString multiLingString) {
    return isEmptyTranslationMap(multiLingString.toMap());
  }

  /// Checks if a map of translations is empty.
  static bool isEmptyTranslationMap(Map<String, String> translations) {
    if (translations.isEmpty) {
      return true;
    }
    for (var translation in translations.values) {
      if (isEmptyString(translation)) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a list of LatLng is entirely filled and ready to be used for an event BO.
  static bool isIncompleteLatLngListForEvent(List<LatLng> coordinates) {
    if (coordinates.length < GlobalConstants.eventMinCoordinatesNb) {
      return true;
    }
    return false;
  }

  /// Checks if a map of LatLng linked to a year is entirely filled and ready to be used for an object BO.
  static bool isIncompleteLatLngListForObject(Map<int, LatLng> coordinates) {
    if (coordinates.length < GlobalConstants.objectMinCoordinatesNb) {
      return true;
    }
    return false;
  }

  /// Checks if a list of QuizOption is entirely filled and ready to be used for a quiz BO.
  static bool isIncompleteQuizOptionList(List<QuizOption> newQuizOptVals) {
    if (newQuizOptVals.length < GlobalConstants.quizOptionMinNb) {
      return true;
    }
    return false;
  }
}
