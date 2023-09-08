import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/app_localization.dart';
import '../util/base_bo_list_widget.dart';
import '../helper/globals.dart';
import 'expo_object_editor_widget.dart';

/// Class ExpoObjectListWidget is used to list a collection of ExpoObject. Inherits from BaseBOListWidget.
class ExpoObjectListWidget extends BaseBOListWidget {
  /// Creates a new ExpoObjectListWidget.
  ExpoObjectListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("objects"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .exposition
                    .objects,
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoObjectEditorWidget(
                    object: (item as ExpoObject),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoObjectEditorWidget(),
                ),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("object_add"));
}
