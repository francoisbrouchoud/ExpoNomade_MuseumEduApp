import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../util/base_bo_list_widget.dart';
import '../util/globals.dart';
import 'expo_population_type_editor_widget.dart';

/// Class ExpoPopulationTypeListWidget is used to list a collection of ExpoPopulationType. Inherits from BaseBOListWidget.
class ExpoParticipationTypeListWidget extends BaseBOListWidget {
  /// Creates a new ExpoPopulationTypeListWidget.
  ExpoParticipationTypeListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("quiz_result"),
            listableItems: Provider.of<DataNotifier>(context, listen: true)
                .exposition
                .participations
                .toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            addButtonText: AppLocalization.of(context)
                .getTranslation("population_type_add"));
}
