import 'package:expo_nomade_mobile/admin/museum_editor_widget.dart';
import 'package:expo_nomade_mobile/bo/museum.dart';
import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/helper/notifer_helper.dart';
import 'package:expo_nomade_mobile/widgets/base_bo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Class MuseumListWidget is used to list a collection of Museum. Inherits from BaseBOListWidget.
class MuseumListWidget extends BaseBOListWidget {
  /// Creates a new MuseumListWidget.
  MuseumListWidget({super.key, required BuildContext context})
      : super(
          title: AppLocalization.of(context).getTranslation("museums"),
          listableItems:
              Provider.of<MuseumNotifier>(context).museums.values.toList(),
          itemTap: (item) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MuseumEditorWidget(
                  museum: (item as Museum),
                ),
              ),
            );
          },
          itemAddRequested: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MuseumEditorWidget(),
              ),
            );
          },
          addButtonText:
              AppLocalization.of(context).getTranslation("museum_creation"),
        );
}
