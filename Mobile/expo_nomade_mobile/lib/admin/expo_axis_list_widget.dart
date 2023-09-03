import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/util/base_bo_list_widget.dart';
import 'package:flutter/material.dart';

import '../bo/expo_axis.dart';
import 'expo_axis_editor_widget.dart';

/// Class ExpoAxisListWidget is used to list a collection of ExpoAxis. Inherits from BaseBOListWidget.
class ExpoAxisListWidget extends BaseBOListWidget {
  /// Creates a new ExpoAxisListWidget.
  ExpoAxisListWidget(
      {super.key,
      required BuildContext context,
      required Exposition exposition})
      : super(
            title: AppLocalization.of(context).getTranslation("axis"),
            listableItems: exposition.axes.values.toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoAxisEditorWidget(
                    exposition: exposition,
                    axisId: (item as ExpoAxis).id,
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ExpoAxisEditorWidget(exposition: exposition),
                ),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("axis_add"));
}
