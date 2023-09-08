import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';
import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:expo_nomade_mobile/util/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_axis.dart';
import '../util/globals.dart';

/// Class ExpoAxisEditorWidget is a widget used to edit or create an ExpoAxis object.
class ExpoAxisEditorWidget extends StatefulWidget {
  final ExpoAxis? axis;

  /// ExpoAxisEditorWidget constructor.
  const ExpoAxisEditorWidget({super.key, this.axis});

  @override
  _ExpoAxisEditorWidgetState createState() => _ExpoAxisEditorWidgetState();
}

/// State class for the ExpoAxisEditorWidget.
class _ExpoAxisEditorWidgetState extends State<ExpoAxisEditorWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// Navigates back to the list view.
  void backToList() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;
    Map<String, String> newTitleVals = widget.axis?.title.toMap() ?? {};
    Map<String, String> newDescVals = widget.axis?.description.toMap() ?? {};
    return Material(
      child: BaseBOEditorWidget(
        title: widget.axis != null
            ? translations.getTranslation("axis_edit")
            : translations.getTranslation("axis_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("title"),
            value: widget.axis?.title,
            valueChanged: (newVals) => newTitleVals = newVals,
            mandatory: true,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("description"),
            value: widget.axis?.description,
            valueChanged: (newVals) => newDescVals = newVals,
          ),
        ],
        object: widget.axis,
        itemSaveRequested: () async {
          if (!ValidationHelper.isEmptyTranslationMap(newTitleVals)) {
            ExpoAxis axis = ExpoAxis("", MultilingualString(newDescVals),
                MultilingualString(newTitleVals));
            if (widget.axis != null) {
              axis = widget.axis!;
              axis.title = MultilingualString(newTitleVals);
              axis.description = MultilingualString(newDescVals);
              await FirebaseService.updateAxis(axis);
            } else {
              ExpoAxis? newAxis = await FirebaseService.createAxis(axis);
              if (newAxis != null) {
                expo.axes.putIfAbsent(newAxis.id, () => newAxis);
              }
            }
            dataProvider.forceRelaod();
            SimpleSnackBar.showSnackBar(
                context, translations.getTranslation("saved"));
            backToList();
          } else {
            SimpleSnackBar.showSnackBar(context,
                translations.getTranslation("fill_required_fields_msg"));
          }
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteAxis(widget.axis!);
          expo.axes.remove(widget.axis!);
          dataProvider.forceRelaod();
          backToList();
        },
        hasDependencies: expo.events
                .where((event) => event.axis.id == widget.axis?.id)
                .isNotEmpty ||
            expo.objects
                .where((obj) => obj.axis.id == widget.axis?.id)
                .isNotEmpty,
      ),
    );
  }
}
