import 'package:expo_nomade_mobile/admin/expo_axis_list_widget.dart';
import 'package:expo_nomade_mobile/admin/expo_object_list_widget.dart';
import 'package:expo_nomade_mobile/admin/expo_participation_widget.dart';
import 'package:expo_nomade_mobile/admin/expo_quiz_list_widget.dart';
import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_name.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../helper/firebase_service.dart';
import '../util/bo_selector_widget.dart';
import '../util/container_admin_widget.dart';
import 'exp_list_widget.dart';
import 'expo_event_list_widget.dart';
import 'expo_population_type_list_widget.dart';
import '../helper/globals.dart';

/// Class MenuPage displays the administration menu.
class MenuPage extends StatefulWidget {
  /// Creates a new MenuPage
  const MenuPage({Key? key})
      : super(key: key); // Correction du nom du paramètre

  @override
  State<MenuPage> createState() => _MenuPageState();
}

/// State class for the MenuPage.
class _MenuPageState extends State<MenuPage> {
  /// Signs out the connected user.
  Future<bool> _onWillPop(BuildContext context) async {
    final loginProvider = Provider.of<LoginNotifier>(context, listen: false);
    FirebaseAuth.instance.signOut();
    loginProvider.setIsLogin(false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);

    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: ContainerAdminWidget(
          fixedContainerHeight: true,
          title: translations.getTranslation("admin"),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: GlobalConstants.containerLittlePaddingHorizontal),
            child: ListView(
              children: <Widget>[
                SelectExpo(dataProvider: dataProvider),
                const SizedBox(height: GlobalConstants.sizeOfTheBlock),
                const Menu()
              ],
            ),
          ),
        ));
  }
}

/// SelectExpo creates the part to select the current exposition
class SelectExpo extends StatelessWidget {
  /// Creates a new SelectExpo
  const SelectExpo({super.key, required this.dataProvider});
  final ExpositionNotifier dataProvider;
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final theme = Theme.of(context);

    return Column(children: [
      Text(translations.getTranslation("selectExpo"),
          style: theme.textTheme.displaySmall),
      BOSelectorWidget(
        name: translations.getTranslation("expo"),
        preSel: dataProvider.expositions[dataProvider.exposition.id],
        objects: dataProvider.expositions.values.toList(),
        selectedItemChanged: (newVal) =>
            setCurrentExpo(newVal as ExpoName, dataProvider, context),
        mandatory: true,
      )
    ]);
  }

  /// Handles the click event on any expo button
  setCurrentExpo(ExpoName expoName, ExpositionNotifier dataProvider,
      BuildContext context) async {
    await FirebaseService.setCurrentExposition(expoName.id);
    var expo = await FirebaseService.getCurrentExposition();
    dataProvider.setExposition(expo!);
  }
}

/// Class Menu contains all buttons that must be displayed in the MenuPage.
class Menu extends StatelessWidget {
  /// Creates a new Menu
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final theme = Theme.of(context);
    return Column(children: [
      Text(translations.getTranslation("titleMenu"),
          style: theme.textTheme.displaySmall),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("show_result"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpoParticipationListWidget(context: context)),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("quiz"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpoQuizListWidget(context: context)),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("axis"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpoAxisListWidget(context: context)),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("population_types"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ExpoPopulationTypeListWidget(context: context),
                  ),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("events"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpoEventListWidget(context: context),
                  ),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: translations.getTranslation("objects"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ExpoObjectListWidget(context: context),
                  ),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: 25),
      ButtonWidget(
          text: translations.getTranslation("expo"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpoListWidget(context: context),
                  ),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: GlobalConstants.sizeOfTheBlock),
      ButtonWidget(
          text: "Logout",
          action: () {
            final loginProvider =
                Provider.of<LoginNotifier>(context, listen: false);
            FirebaseAuth.instance.signOut();
            loginProvider.setIsLogin(false);
          },
          type: ButtonWidgetType.delete)
    ]);
  }
}
