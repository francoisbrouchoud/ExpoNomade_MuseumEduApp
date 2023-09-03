import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/base_bo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_axis.dart';
import '../util/globals.dart';
import 'expo_axis_editor_widget.dart';

/// Class ExpoAxisListWidget is used to list a collection of ExpoAxis. Inherits from BaseBOListWidget.
class ExpoAxisListWidget extends BaseBOListWidget {
  /// Creates a new ExpoAxisListWidget.
  ExpoAxisListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("axis"),
            listableItems: Provider.of<DataNotifier>(context, listen: true)
                .exposition
                .axes
                .values
                .toList(),
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoAxisEditorWidget(
                    axisId: (item as ExpoAxis).id,
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ExpoAxisEditorWidget()),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("axis_add"));
}
