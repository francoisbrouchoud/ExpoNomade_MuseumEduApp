import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../util/base_bo_list_widget.dart';
import '../util/globals.dart';
import 'expo_population_type_editor_widget.dart';

/// Class ExpoPopulationTypeListWidget is used to list a collection of ExpoPopulationType. Inherits from BaseBOListWidget.
class ExpoPopulationTypeListWidget extends BaseBOListWidget {
  /// Creates a new ExpoPopulationTypeListWidget.
  ExpoPopulationTypeListWidget({super.key, required BuildContext context})
      : super(
            title:
                AppLocalization.of(context).getTranslation("population_types"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .exposition
                    .populationTypes
                    .values
                    .toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoPopulationTypeEditorWidget(
                    populationType: (item as ExpoPopulationType),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoPopulationTypeEditorWidget(),
                ),
              );
            },
            addButtonText: AppLocalization.of(context)
                .getTranslation("population_type_add"));
}
