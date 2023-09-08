import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/util/base_bo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_axis.dart';
import '../helper/globals.dart';
import 'expo_axis_editor_widget.dart';

/// Class ExpoAxisListWidget is used to list a collection of ExpoAxis. Inherits from BaseBOListWidget.
class ExpoAxisListWidget extends BaseBOListWidget {
  /// Creates a new ExpoAxisListWidget.
  ExpoAxisListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("axis"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .exposition
                    .axes
                    .values
                    .toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoAxisEditorWidget(
                    axis: (item as ExpoAxis),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoAxisEditorWidget(),
                ),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("axis_add"));
}
