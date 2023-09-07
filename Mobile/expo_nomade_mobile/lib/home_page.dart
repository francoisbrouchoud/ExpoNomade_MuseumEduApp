import 'package:expo_nomade_mobile/admin/menu_page.dart';
import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map/map_page.dart';
import 'quiz/quiz_page.dart';
import 'util/title_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(key: key); // Correction du nom du paramètre

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MenuPage(),
              ),
            );
          },
          child: Text(translations.getTranslation("admin"))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleWidget(
                text: Provider.of<ExpositionNotifier>(context)
                    .exposition
                    .name[translations.getCurrentLangCode()]),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWidget(
                  action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                            questions: dataProvider.exposition.quiz.questions),
                      ),
                    );
                  },
                  text: translations.getTranslation("quiz"),
                  type: ButtonWidgetType.home,
                ),
                const SizedBox(width: 25),
                ButtonWidget(
                  action: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MapPage(exposition: dataProvider.exposition),
                      ),
                    );
                  },
                  text: translations.getTranslation("map"),
                  type: ButtonWidgetType.home,
                ),
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
