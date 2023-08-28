class MultilingualString {
  Map<String, String> translations;

  MultilingualString(this.translations);

  String operator [](String langCode) {
    return translations[langCode] ?? "";
  }

  Map<String, String> toMap() {
    return translations;
  }
}
