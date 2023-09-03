import 'package:expo_nomade_mobile/admin/expo_axis_list_widget.dart';
import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bo/exposition.dart';
import '../util/container_admin_widget.dart';
import 'expo_population_type_list_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.exposition})
      : super(key: key); // Correction du nom du paramètre

  final Exposition exposition;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return ContainerAdminWidget(
        refresh: () => {setState(() {})},
        title: translations.getTranslation("admin"),
        body: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SelectExpo(exposition: widget.exposition),
                const SizedBox(height: 25),
                Menu(
                    exposition: widget.exposition,
                    refresh: () {
                      setState(() {});
                    })
              ],
            ),
          ),
        ));
  }
}

class SelectExpo extends StatelessWidget {
  const SelectExpo({super.key, required this.exposition});
  final Exposition exposition;
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final theme = Theme.of(context);
    return Column(children: [
      Text(translations.getTranslation("selectExpo"),
          style: theme.textTheme.displaySmall)
    ]);
  }

  /// Handles the click event on any language button
  setCurrentExpo(String expoId, BuildContext context) {}
}

class Menu extends StatelessWidget {
  const Menu({super.key, required this.exposition, required this.refresh});
  final Exposition exposition;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final theme = Theme.of(context);
    return Column(children: [
      Text(translations.getTranslation("titleMenu"),
          style: theme.textTheme.displaySmall),
      const SizedBox(height: 25),
      ButtonWidget(
          text: translations.getTranslation("axis"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ExpoAxisListWidget(
                          context: context, exposition: exposition)),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: 25),
      ButtonWidget(
          text: translations.getTranslation("population_types"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpoPopulationTypeListWidget(
                        context: context, exposition: exposition),
                  ),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: 25),
      ButtonWidget(
          text: "logout",
          action: () {
            FirebaseAuth.instance.signOut();
            refresh();
          },
          type: ButtonWidgetType.standard)
    ]);
  }
}
