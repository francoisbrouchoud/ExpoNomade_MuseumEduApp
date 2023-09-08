import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/widgets/base_bo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_event.dart';
import '../helper/notifer_helper.dart';
import 'expo_event_editor_widget.dart';

/// Class ExpoEventListWidget is used to list a collection of ExpoEvent. Inherits from BaseBOListWidget.
class ExpoEventListWidget extends BaseBOListWidget {
  /// Creates a new ExpoEventListWidget.
  ExpoEventListWidget({super.key, required BuildContext context})
      : super(
            title: AppLocalization.of(context).getTranslation("events"),
            listableItems:
                Provider.of<ExpositionNotifier>(context, listen: true)
                    .exposition
                    .events,
            itemTap: (item) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpoEventEditorWidget(
                    event: (item as ExpoEvent),
                  ),
                ),
              );
            },
            itemAddRequested: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExpoEventEditorWidget(),
                ),
              );
            },
            addButtonText:
                AppLocalization.of(context).getTranslation("event_add"));
}
