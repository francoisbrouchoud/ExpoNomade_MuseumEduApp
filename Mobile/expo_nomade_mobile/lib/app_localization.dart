import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Contains all available languages in the application
class Language {
  final String name;
  final String langCode;

  Language(this.name, this.langCode);

  /// Returns the list of all available languages in the application
  ///
  /// Any new language must be added in the list here and a json file with the same language code must be added in the assets/lang folder.
  /// For example, steps to add italian language:
  /// 1. Add the line "Language("Italiano", "it") in the following method"
  /// 2. Add the language flag "it.png" in the "assets/images" folder.
  /// 3. Create the file "it.json" in the "assets/lang" folder.
  /// 4. Add the translations key-value pairs in the file.
  /// 5. You're all set, the translation button will be automatically added on the home page and working.
  static List<Language> langList() {
    return <Language>[
      Language("Français", "fr"),
      Language("Deutsch", "de"),
    ];
  }
}

/// Contains the application localization information
class AppLocalization {
  late final Locale _locale;
  AppLocalization(this._locale);

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();

  static final supportedLanguages =
      Language.langList().map((e) => e.langCode).toSet();

  static final supportedLocales = supportedLanguages.map((e) => Locale(e));

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates =
      [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalization.delegate
  ];

  /// Returns the localization of the context, used to get the AppLocalization
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizedTranslations;

  /// Loads the application's translation in the current language
  Future loadLang() async {
    String jsonVals =
        await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    Map<String, dynamic> mappedVals = json.decode(jsonVals);
    _localizedTranslations =
        mappedVals.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Gets a translation in the current language by it's [key] defined in the assets/lang/XX.json files
  String getTranslation(String key) {
    if (_localizedTranslations.containsKey(key)) {
      return _localizedTranslations[key]!;
    }
    return "Missing translation for '$key' in '${getCurrentLangCode()}'.";
  }

  /// Gets the current language code
  String getCurrentLangCode() {
    return _locale.languageCode;
  }
}

/// Contains the application localization delegate
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalization.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLang();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}

/// Contains the locale notifier information
class LocaleNotifier extends ChangeNotifier {
  Locale _locale = Locale(Language.langList().first.langCode);

  Locale get locale => _locale;

  /// Updates the current locale and notifies the listeners
  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
