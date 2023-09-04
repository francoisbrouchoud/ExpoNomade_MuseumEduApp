import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/validation_helper.dart';

/// Class MultilingualString is used to manage translated properties.
class MultilingualString {
  Map<String, String> translations;

  /// Creates a new MultilingualString based on the map provided.
  MultilingualString(this.translations);

  /// Returns the translation in the language provided by the lang code. If no translation exists for the lang code, an empty string will be returned.
  String operator [](String langCode) {
    String val = translations[langCode] ?? "";
    if (val.isNotEmpty && isEmpty(val)) {
      val = "";
    }
    return val;
  }

  /// Returns all the values of the MultilingualString in a Map format.
  Map<String, String> toMap() {
    if (translations.isNotEmpty) {
      return translations;
    } else {
      return {for (var lang in Language.langList()) lang.langCode: emptyString};
    }
  }
}
