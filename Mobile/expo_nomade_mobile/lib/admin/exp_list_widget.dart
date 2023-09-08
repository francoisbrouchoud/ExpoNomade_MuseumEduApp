import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/app_localization.dart';
import '../bo/expo_name.dart';
import '../util/base_bo_list_widget.dart';
import '../helper/globals.dart';
import 'expo_editor_widget.dart';

/// Class ExpoListWidget is used to list a collection of ExpoPopulationType. Inherits from BaseBOListWidget.
class ExpoListWidget extends BaseBOListWidget {
  /// Creates a new ExpoListWidget.
  ExpoListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("expo"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .expositions
                    .values
                    .toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoEditorWidget(
                    expo: (item as ExpoName),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoEditorWidget(),
                ),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("expo_add"));
}
