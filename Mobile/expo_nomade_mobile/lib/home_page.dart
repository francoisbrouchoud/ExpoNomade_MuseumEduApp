import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map/map_page.dart';
import 'quiz/quiz_page.dart';
import 'quiz/quiz_question';

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
            TitleName(),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainButton(
                    action: () {
                      print("quiz");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            //Les questions seront déplacées sur la DB mais en attendant elles sont en dur ici
                            questions: [
                              QuizQuestion(
                                question:
                                    'De quel pays proviennent principalement les ouvriers qui ont construit le tunnel du Simplon ?',
                                options: ['France', 'Allemagne', 'Italie'],
                                answerIdx: 2,
                              ),
                              QuizQuestion(
                                question:
                                    'En quel année a été terminé le premier tube tunnel du Simplon ?',
                                options: ['1859', '1905', '1921', '1980'],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'Qui a traversé le col du Grand St-Bernard avec un éléphant ?',
                                options: [
                                  'Louis XIV',
                                  'Hannibal',
                                  'Jules César'
                                ],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'En 2020, quel pays représentait la plus grande communauté étrangère résidant en Valais ?',
                                options: [
                                  'Portugal',
                                  'France',
                                  'Italie',
                                  'Espagne'
                                ],
                                answerIdx: 0,
                              ),
                              QuizQuestion(
                                question:
                                    'Dans l\'Antiquité, quel peuple occupait principalement la région du Valais avant la conquête romaine?',
                                options: [
                                  'Les Helvètes',
                                  'Les Rauraques',
                                  'Les Sedunes',
                                  'Les Allobroges'
                                ],
                                answerIdx: 2,
                              ),
                              QuizQuestion(
                                question:
                                    'Durant quel siècle le Valais a-t-il été intégré à l\'Empire carolingien?',
                                options: [
                                  'VIe siècle',
                                  'VIIIe siècle',
                                  'IXe siècle',
                                  'XIe siècle'
                                ],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'Quelle route commerciale importante traversait le Valais dans l\'Antiquité et le Moyen Âge, favorisant les mouvements migratoires?',
                                options: [
                                  'Route de la soie',
                                  'Route du sel',
                                  'Route de l\'ambre',
                                  'Route du poivre'
                                ],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'Le Valais est devenu un évêché indépendant au début duquel siècle, consolidant ainsi son autonomie?',
                                options: [
                                  'Xe siècle',
                                  'XIIe siècle',
                                  'XIVe siècle',
                                  'XVIe siècle'
                                ],
                                answerIdx: 2,
                              ),
                              QuizQuestion(
                                question:
                                    'Durant les invasions barbares, quel peuple germanique a traversé et parfois occupé le Valais, influençant sa démographie?',
                                options: [
                                  'Les Vandales',
                                  'Les Burgondes',
                                  'Les Wisigoths',
                                  'Les Ostrogoths'
                                ],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'Quelle ligne ferroviaire, inaugurée à la fin du 19ème siècle, a considérablement renforcé les liens entre le Valais et le reste de la Suisse?',
                                options: [
                                  'Ligne du Gotthard',
                                  'Ligne de la Furka',
                                  'Ligne du Lötschberg',
                                  'Ligne du Simplon'
                                ],
                                answerIdx: 3,
                              ),
                              QuizQuestion(
                                question:
                                    'Durant la Première Guerre mondiale, le Valais a accueilli de nombreux réfugiés de quel pays voisin?',
                                options: [
                                  'Allemagne',
                                  'France',
                                  'Italie',
                                  'Autriche'
                                ],
                                answerIdx: 2,
                              ),
                              QuizQuestion(
                                question:
                                    'À la suite de la construction de grands barrages hydroélectriques au 20ème siècle, le Valais a vu une augmentation de migrants venant principalement de quel pays?',
                                options: [
                                  'Portugal',
                                  'Italie',
                                  'Espagne',
                                  'Grèce'
                                ],
                                answerIdx: 1,
                              ),
                              QuizQuestion(
                                question:
                                    'Durant la Seconde Guerre mondiale, quel col du Valais a été particulièrement utilisé par les réfugiés fuyant l\'occupation?',
                                options: [
                                  'Col du Simplon',
                                  'Col de la Furka',
                                  'Col du Grand St-Bernard',
                                  'Col du Lötschberg'
                                ],
                                answerIdx: 2,
                              ),
                              QuizQuestion(
                                question:
                                    'Au 20ème siècle, quelle industrie du Valais a particulièrement attiré des travailleurs étrangers, notamment en raison de la croissance du tourisme?',
                                options: [
                                  'Viticulture',
                                  'Horlogerie',
                                  'Construction',
                                  'Hôtellerie'
                                ],
                                answerIdx: 3,
                              ),
                            ],
                          ),
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

class TitleName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: FirebaseService.getExpositionName(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else {
            return const CircularProgressIndicator();
          }
        });
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
