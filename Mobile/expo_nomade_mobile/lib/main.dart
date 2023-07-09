import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'mappage.dart';
import 'app_localization.dart';

void main() {
  runApp(const App());
}

/// It is the class that contains the root
class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleNotifier>.value(
      value: LocaleNotifier(),
      builder: (context, child) {
        final appLocaleProvider = Provider.of<LocaleNotifier>(context);
        return MaterialApp(
          locale: appLocaleProvider.locale,
          localizationsDelegates: AppLocalization.localizationsDelegates,
          supportedLocales: AppLocalization.supportedLocales,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          title: 'Expo Nomade',

          /// TODO : define with Julienne
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 230, 147, 14),
                primary: Color.fromARGB(255, 230, 147, 14),
                onPrimary: Color.fromARGB(255, 0, 0, 0),
                secondary: Color.fromARGB(255, 252, 240, 221),
                onSecondary: Color.fromARGB(255, 40, 40, 40)),
            textTheme:
                const TextTheme(bodyMedium: TextStyle(fontFamily: 'Arial')),
            useMaterial3: true,
          ),
          home: const HomePage(title: 'Expo Nomade'),
          routes: {
            '/map': (context) => MapPage(),
            '/quiz': (context) => Placeholder(),
          },
        );
      },
    );
  }
}
