import 'package:expo_nomade_mobile/admin/expo_axis_list_widget.dart';
import 'package:expo_nomade_mobile/admin/expo_population_type_list_widget.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/quiz/quiz_page.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin/menu_page.dart';
import 'bo/exposition.dart';
import 'firebase_options.dart';
import 'firebase_service.dart';
import 'home_page.dart';
import 'map/map_page.dart';
import 'app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

/// It is the class that contains the root
class App extends StatelessWidget {
  const App({super.key});

  static const primary = Color(0xFFBCC1EC);
  static const secondary = Color(0xFF676664);
  static const tertiary = Color(0xFF1B8989);
  static const error = Color(0xFF942A3D);
  static const background = Color(0xFFEEEEEE);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleNotifier()),
        ChangeNotifierProvider(create: (context) => DataNotifier())
      ],
      builder: (context, child) {
        final appLocaleProvider = Provider.of<LocaleNotifier>(context);
        final dataProvider = Provider.of<DataNotifier>(context);
        return FutureBuilder<Exposition?>(
            future: FirebaseService.getCurrentExposition(),
            builder: (context, AsyncSnapshot<Exposition?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  // TODO utilisation trad
                  return const Text("no_data");
                } else {
                  final Exposition expo = snapshot.data!;
                  dataProvider.setExposition(expo);
                  return MaterialApp(
                    locale: appLocaleProvider.locale,
                    localizationsDelegates:
                        AppLocalization.localizationsDelegates,
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

                    /// TODO : Julienne review
                    theme: ThemeData(
                      colorScheme: ColorScheme.fromSeed(
                          seedColor: primary,
                          primary: primary,
                          error: error,
                          secondary: secondary,
                          background: background,
                          tertiary: tertiary),
                      textTheme: const TextTheme(
                          displayMedium: TextStyle(fontFamily: 'Montserrat'),
                          displaySmall:
                              TextStyle(fontSize: 26, color: secondary)),
                      useMaterial3: true,
                    ),
                    home: const HomePage(),
                    routes: {
                      '/map': (context) =>
                          MapPage(exposition: dataProvider.exposition),
                      '/quiz': (context) => QuizPage(
                          questions: dataProvider.exposition.quiz.questions),
                      '/admin': (context) => const MenuPage(),
                      '/admin/axis': (context) =>
                          ExpoAxisListWidget(context: context),
                      '/admin/populationType': (context) =>
                          ExpoPopulationTypeListWidget(context: context)
                    },
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            });
      },
    );
  }
}
