import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Language {
  final String name;
  final String langCode;

  Language(this.name, this.langCode);

  static List<Language> langList() {
    return <Language>[
      Language("Français", "fr"),
      Language("Deutsch", "de"),
    ];
  }
}

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

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  late Map<String, String> _localizedTranslations;

  Future loadLang() async {
    String jsonVals =
        await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    Map<String, dynamic> mappedVals = json.decode(jsonVals);
    _localizedTranslations =
        mappedVals.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslation(String key) {
    return _localizedTranslations[key];
  }
}

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

class LocaleNotifier extends ChangeNotifier {
  Locale _locale = Locale(Language.langList().first.langCode);

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }
}
