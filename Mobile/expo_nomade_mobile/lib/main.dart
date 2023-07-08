import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'homepage.dart';
import 'mappage.dart';

void main() {
  runApp(const App());
}

/// It is the class that contains the root
class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expo Nomade',

      /// TODO : define with Julienne
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 230, 147, 14),
            primary: Color.fromARGB(255, 230, 147, 14),
            onPrimary: Color.fromARGB(255, 0, 0, 0),
            secondary: Color.fromARGB(255, 252, 240, 221),
            onSecondary: Color.fromARGB(255, 40, 40, 40)),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontFamily: 'Arial')),
        useMaterial3: true,
      ),
      locale: const Locale('fr'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(title: 'Expo Nomade'),
      routes: {
        '/map': (context) => MapPage(),
        '/quiz': (context) => Placeholder(),
      },
    );
  }
}
