import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mappage.dart';

/// Contains the homepage builder
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Containes the home page content with the state
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Logo',
            ),
            SizedBox(height: 50),
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
                    text: translations.quiz),
                SizedBox(width: 25),
                MainButton(
                    action: () {
                      print("map");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MapPage(),
                        ),
                      );
                    },
                    text: translations.map),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                LangButton(
                  action: () {
                    print("BTN FR CLICK");
                  },
                  text: translations.lang_fr,
                ),
                SizedBox(width: 50),
                LangButton(
                  action: () {
                    print("BTN DE CLICK");
                  },
                  text: translations.lang_de,
                ),
              ],
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
      color: theme.colorScheme.onPrimary,
    );
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(text, style: btnTextStyle)));
  }
}

/// Contain the design of a language button from the homepage
/// TODO : add a flag instad of icon
class LangButton extends StatelessWidget {
  const LangButton({super.key, required this.text, required this.action});

  final String text;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lanTextStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSecondary,
    );
    return ElevatedButton.icon(
        onPressed: action,
        icon: Icon(Icons.flag),
        label: Text(text, style: lanTextStyle),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.secondary,
        ));
  }
}
