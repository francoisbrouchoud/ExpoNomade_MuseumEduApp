import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AppLocalizations translations = AppLocalizations.of(context)!;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
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
                    },
                    text: translations.quiz),
                SizedBox(width: 25),
                MainButton(
                    action: () {
                      print("map");
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
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(text, style: btnTextStyle)));
  }
}

class LangButton extends StatelessWidget {
  const LangButton({super.key, required this.text, required this.action});

  final String text;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lanTextStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return ElevatedButton.icon(
      onPressed: action,
      icon: Icon(Icons.flag),
      label: Text(text, style: lanTextStyle),
    );
  }
}
