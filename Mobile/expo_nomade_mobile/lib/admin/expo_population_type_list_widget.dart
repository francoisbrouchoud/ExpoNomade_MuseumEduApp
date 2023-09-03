import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:flutter/material.dart';

import '../app_localization.dart';
import '../bo/exposition.dart';
import '../util/base_bo_list_widget.dart';
import 'expo_population_type_editor_widget.dart';

/// Class ExpoPopulationTypeListWidget is used to list a collection of ExpoPopulationType. Inherits from BaseBOListWidget.
class ExpoPopulationTypeListWidget extends BaseBOListWidget {
  /// Creates a new ExpoPopulationTypeListWidget.
  ExpoPopulationTypeListWidget(
      {super.key,
      required BuildContext context,
      required Exposition exposition})
      : super(
            title:
                AppLocalization.of(context).getTranslation("population_types"),
            listableItems: exposition.populationTypes.values.toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoPopulationTypeEditorWidget(
                    exposition: exposition,
                    popTypeId: (item as ExpoPopulationType).id,
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ExpoPopulationTypeEditorWidget(exposition: exposition),
                ),
              );
            },
            addButtonText: AppLocalization.of(context)
                .getTranslation("population_type_add"));
}
