import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map_page.dart';

/// Contains the homepage builder
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Contains the home page content with the state
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Logo',
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainButton(
                    action: () {
                      print("quiz");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Placeholder(),
                        ),
                      );
                    },
                    text: translations.getTranslation("quiz").toString()),
                const SizedBox(width: 25),
                MainButton(
                    action: () {
                      print("map");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MapPage(),
                        ),
                      );
                    },
                    text: translations.getTranslation("map").toString()),
              ],
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: Language.langList()
                    .map((e) => LangButton(lang: e))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Contain the design of a main button from the homepage
class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.text, required this.action});

  final String text;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.background,
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(text, style: btnTextStyle)));
  }
}

/// Contain the design of a language button from the homepage
class LangButton extends StatelessWidget {
  const LangButton({super.key, required this.lang});

  final Language lang;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: () {
        setLanguage(lang, context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.background,
      ),
      icon: Image.asset(
        'assets/images/${lang.langCode}.png',
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Handles the click event on any language button
  setLanguage(Language e, BuildContext context) {
    final appLocaleProvider =
        Provider.of<LocaleNotifier>(context, listen: false);
    appLocaleProvider.setLocale(Locale(e.langCode));
  }
}
