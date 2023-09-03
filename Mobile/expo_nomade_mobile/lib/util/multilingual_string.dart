/// Class MultilingualString is used to manage translated properties.
class MultilingualString {
  Map<String, String> translations;

  /// Creates a new MultilingualString based on the map provided.
  MultilingualString(this.translations);

  /// Returns the translation in the language provided by the lang code. If no translation exists for the lang code, an empty string will be returned.
  String operator [](String langCode) {
    return translations[langCode] ?? "";
  }

  /// Returns all the values of the MultilingualString in a Map format.
  Map<String, String> toMap() {
    return translations;
  }
}
