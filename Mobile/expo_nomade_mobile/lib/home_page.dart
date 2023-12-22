import 'package:expo_nomade_mobile/admin/menu_page.dart';
import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/widgets/button_widget.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/notifer_helper.dart';

import 'map/map_page.dart';
import 'quiz/quiz_page.dart';
import 'widgets/title_widget.dart';

/// Home page for the application.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// State class for the HomePage widget.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context, listen: true);
    final bool hasQuestions = dataProvider.exposition.quiz.questions.isNotEmpty;
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
                text: dataProvider
                    .exposition.name[translations.getCurrentLangCode()]),
            const SizedBox(height: GlobalConstants.homePageTitleBSpacing),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (hasQuestions)
                  ButtonWidget(
                    action: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                              questions:
                                  dataProvider.exposition.quiz.questions),
                        ),
                      );
                    },
                    text: translations.getTranslation("quiz"),
                    type: ButtonWidgetType.home,
                  ),
                if (hasQuestions)
                  const SizedBox(
                      width: GlobalConstants.homePageMainButtonSpacing),
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
            const SizedBox(height: GlobalConstants.homePageTitleBSpacing),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Language.langList().map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GlobalConstants.langBtnHSpacing),
                  child: LangButton(lang: e),
                );
              }).toList(),
            ),
            //),
          ],
        ),
      ),
    );
  }
}

/// Contain the design of a language button from the HomePage.
class LangButton extends StatelessWidget {
  /// Creates a new lang button widget.
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
        width: GlobalConstants.langBtnWidth,
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
