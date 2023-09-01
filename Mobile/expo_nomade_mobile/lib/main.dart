import 'package:expo_nomade_mobile/admin/expo_axis_list.dart';
import 'package:expo_nomade_mobile/admin/login_page.dart';
import 'package:expo_nomade_mobile/quiz/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleNotifier>.value(
      value: LocaleNotifier(),
      builder: (context, child) {
        final appLocaleProvider = Provider.of<LocaleNotifier>(context);
        return FutureBuilder<Exposition?>(
            future: FirebaseService.getCurrentExposition(),
            builder: (context, AsyncSnapshot<Exposition?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  // TODO error msg
                  return const Text("ERROR");
                } else {
                  final Exposition expo = snapshot.data!;
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
                        seedColor: const Color(0xFFBCC1EC),
                        primary: const Color(0xFFBCC1EC),
                        //onPrimary: const Color.fromARGB(255, 0, 0, 0),
                        secondary: const Color(0xFF676664),
                        background: const Color(0xFFEEEEEE),
                        //onSecondary: const Color.fromARGB(255, 40, 40, 40),
                      ),
                      textTheme: const TextTheme(
                        bodyMedium: TextStyle(fontFamily: 'Montserrat'),
                      ),
                      useMaterial3: true,
                    ),
                    home: HomePage(
                      exposition: expo,
                    ),
                    routes: {
                      '/map': (context) => MapPage(exposition: expo),
                      '/quiz': (context) =>
                          QuizPage(questions: expo.quiz.questions),
                      '/admin': (context) => LoginPage(exposition: expo),
                      '/admin/axis': (context) =>
                          ExpoAxisListWidget(exposition: expo)
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
