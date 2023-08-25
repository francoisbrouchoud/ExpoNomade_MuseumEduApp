import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'map/map_page.dart';
import 'quiz/quiz_page.dart';
import 'quiz/quiz_question.dart'; // Ajout de l'import manquant

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title})
      : super(key: key); // Correction du nom du paramètre

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

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
                          questions: [
                            QuizQuestion(
                              question:
                                  'De quel pays proviennent principalement les ouvriers qui ont construit le tunnel du Simplon ?',
                              options: [
                                QuizOption(label: 'France'),
                                QuizOption(label: 'Allemagne'),
                                QuizOption(label: 'Italie', isCorrect: true),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'En quel année a été terminé le premier tube tunnel du Simplon ?',
                              options: [
                                QuizOption(label: '1859'),
                                QuizOption(label: '1905', isCorrect: true),
                                QuizOption(label: '1921'),
                                QuizOption(label: '1980'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Qui a traversé le col du Grand St-Bernard avec un éléphant ?',
                              options: [
                                QuizOption(label: 'Louis XIV'),
                                QuizOption(label: 'Hannibal', isCorrect: true),
                                QuizOption(label: 'Jules César'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'En 2020, quel pays représentait la plus grande communauté étrangère résidant en Valais ?',
                              options: [
                                QuizOption(label: 'Portugal', isCorrect: true),
                                QuizOption(label: 'France'),
                                QuizOption(label: 'Italie'),
                                QuizOption(label: 'Espagne'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Dans l\'Antiquité, quel peuple occupait principalement la région du Valais avant la conquête romaine?',
                              options: [
                                QuizOption(label: 'Les Helvètes'),
                                QuizOption(label: 'Les Rauraques'),
                                QuizOption(
                                    label: 'Les Sedunes', isCorrect: true),
                                QuizOption(label: 'Les Allobroges'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Durant quellle siècle le Valais a-t-il été intégré à l\'Empire carolingien?',
                              options: [
                                QuizOption(label: 'VIe siècle'),
                                QuizOption(
                                    label: 'VIIIe siècle', isCorrect: true),
                                QuizOption(label: 'IXe siècle'),
                                QuizOption(label: 'XIe siècle'),
                              ],
                            ),
                            QuizQuestion(
                                question:
                                    'Quelle route commerciale importante traversait le Valais dans l\'Antiquité et le Moyen Âge, favorisant les mouvements migratoires?',
                                options: [
                                  QuizOption(label: 'Route de la soie'),
                                  QuizOption(
                                      label: 'Route du sel', isCorrect: true),
                                  QuizOption(label: 'Route de l\'ambre'),
                                  QuizOption(label: 'Route du poivre'),
                                ]),
                            QuizQuestion(
                              question:
                                  'Le Valais est devenu un évêché indépendant au début duquel siècle, consolidant ainsi son autonomie?',
                              options: [
                                QuizOption(label: 'Xe siècle'),
                                QuizOption(label: 'XIIe siècle'),
                                QuizOption(
                                    label: 'XIVe siècle', isCorrect: true),
                                QuizOption(label: 'XVIe siècle'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Durant les invasions barbares, quel peuple germanique a traversé et parfois occupé le Valais, influençant sa démographie?',
                              options: [
                                QuizOption(label: 'Les Vandales'),
                                QuizOption(
                                    label: 'Les Burgondes', isCorrect: true),
                                QuizOption(label: 'Les Wisigoths'),
                                QuizOption(label: 'Les Ostrogoths'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Quelle ligne ferroviaire, inaugurée à la fin du 19ème siècle, a considérablement renforcé les liens entre le Valais et le reste de la Suisse?',
                              options: [
                                QuizOption(label: 'Ligne du Gotthard'),
                                QuizOption(label: 'Ligne de la Furka'),
                                QuizOption(label: 'Ligne du Lötschberg'),
                                QuizOption(
                                    label: 'Ligne du Simplon', isCorrect: true),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Durant la Première Guerre mondiale, le Valais a accueilli de nombreux réfugiés de quel pays voisin?',
                              options: [
                                QuizOption(label: 'Allemagne'),
                                QuizOption(label: 'France'),
                                QuizOption(label: 'Italie', isCorrect: true),
                                QuizOption(label: 'Autriche'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'À la suite de la construction de grands barrages hydroélectriques au 20ème siècle, le Valais a vu une augmentation de migrants venant principalement de quel pays?',
                              options: [
                                QuizOption(label: 'Portugal'),
                                QuizOption(label: 'Italie', isCorrect: true),
                                QuizOption(label: 'Espagne'),
                                QuizOption(label: 'Grèce'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Durant la Seconde Guerre mondiale, quel col du Valais a été particulièrement utilisé par les réfugiés fuyant l\'occupation?',
                              options: [
                                QuizOption(label: 'Col du Simplon'),
                                QuizOption(label: 'Col de la Furka'),
                                QuizOption(
                                    label: 'Col du Grand St-Bernard',
                                    isCorrect: true),
                                QuizOption(label: 'Col du Lötschberg'),
                              ],
                            ),
                            QuizQuestion(
                              question:
                                  'Au 20ème siècle, quelle industrie du Valais a particulièrement attiré des travailleurs étrangers, notamment en raison de la croissance du tourisme?',
                              options: [
                                QuizOption(label: 'Viticulture'),
                                QuizOption(label: 'Horlogerie'),
                                QuizOption(label: 'Construction'),
                                QuizOption(
                                    label: 'Hôtellerie', isCorrect: true),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  text: translations.getTranslation("quiz").toString(),
                ),
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
                  text: translations.getTranslation("map").toString(),
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

// ... (le reste du code reste inchangé)

class TitleName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return FutureBuilder<String>(
        future: FirebaseService.getExpositionName(
            translations.getCurrentLangCode()),
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
