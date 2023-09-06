import 'package:expo_nomade_mobile/admin/expo_axis_list_widget.dart';
import 'package:expo_nomade_mobile/admin/expo_participation_widget.dart';
import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../firebase_service.dart';
import '../util/container_admin_widget.dart';
import 'exp_list_widget.dart';
import 'expo_event_list_widget.dart';
import 'expo_population_type_list_widget.dart';
import '../util/globals.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key})
      : super(key: key); // Correction du nom du paramètre

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Future<bool> _onWillPop(BuildContext context) async {
    final loginProvider = Provider.of<LoginNotifier>(context, listen: false);
    FirebaseAuth.instance.signOut();
    loginProvider.setIsLogin(false);
    return true;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: ContainerAdminWidget(
            title: translations.getTranslation("admin"),
            body: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SelectExpo(),
                    const SizedBox(height: 25),
                    Menu(refresh: () {
                      setState(() {});
                    })
                  ],
                ),
              ),
            )));
  }
}

class SelectExpo extends StatelessWidget {
  const SelectExpo({super.key});
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final theme = Theme.of(context);
    return Column(children: [
      Text(translations.getTranslation("selectExpo"),
          style: theme.textTheme.displaySmall)
    ]);
  }

  /// Handles the click event on any expo button
  setCurrentExpo(String expoId, BuildContext context) async {
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    var expo = await FirebaseService.getCurrentExposition();
    dataProvider.setExposition(expo!);
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key, required this.refresh});
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
          text: translations.getTranslation("show_result"),
          action: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ExpoParticipationTypeListWidget(context: context)),
                ),
              },
          type: ButtonWidgetType.standard),
      const SizedBox(height: 25),
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
      const SizedBox(height: 25),
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
      const SizedBox(height: 25),
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
      const SizedBox(height: 25),
      ButtonWidget(
          text: "logout",
          action: () {
            final loginProvider =
                Provider.of<LoginNotifier>(context, listen: false);
            FirebaseAuth.instance.signOut();
            loginProvider.setIsLogin(false);
          },
          type: ButtonWidgetType.standard)
    ]);
  }
}
