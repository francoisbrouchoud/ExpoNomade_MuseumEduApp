import 'dart:collection';

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_axis.dart';
import '../util/globals.dart';

/// Class ExpoAxisEditorWidget is a widget used to edit or create an ExpoAxis object.
class ExpoAxisEditorWidget extends StatefulWidget {
  final String? axisId;

  /// ExpoAxisEditorWidget constructor.
  const ExpoAxisEditorWidget({super.key, this.axisId});

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
  void backToList(AppLocalization translations) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final title = translations.getTranslation("title");
    final dataProvider = Provider.of<DataNotifier>(context);
    Exposition expo = dataProvider.exposition;
    Map<String, String> newTitleVals = widget.axisId != null
        ? expo.axes[widget.axisId!]!.title.toMap()
        : HashMap();
    final titleWidget = MultilingualStringEditorWidget(
      name: title,
      value: widget.axisId != null ? expo.axes[widget.axisId!]!.title : null,
      valueChanged: (newVals) => newTitleVals = newVals,
    );
    final description = translations.getTranslation("description");
    Map<String, String> newDescVals = widget.axisId != null
        ? expo.axes[widget.axisId!]!.description.toMap()
        : HashMap();
    final descWidget = MultilingualStringEditorWidget(
        name: description,
        value: widget.axisId != null
            ? expo.axes[widget.axisId!]!.description
            : null,
        valueChanged: (newVals) => newDescVals = newVals);
    return Material(
      child: BaseBOEditorWidget(
        title: widget.axisId != null
            ? translations.getTranslation("axis_edit")
            : translations.getTranslation("axis_creation"),
        content: [
          titleWidget,
          descWidget,
        ],
        object: widget.axisId != null ? expo.axes[widget.axisId!] : null,
        itemSaveRequested: () async {
          ExpoAxis axis = ExpoAxis("", MultilingualString(newDescVals),
              MultilingualString(newTitleVals));
          if (widget.axisId != null) {
            axis = expo.axes[widget.axisId]!;
            axis.title = MultilingualString(newTitleVals);
            axis.description = MultilingualString(newDescVals);
          }
          if (axis.id.isNotEmpty) {
            await FirebaseService.updateAxis(axis);
          } else {
            ExpoAxis? newAxis = await FirebaseService.createAxis(axis);
            if (newAxis != null) {
              expo.axes.putIfAbsent(newAxis.id, () => newAxis);
            }
          }
          dataProvider.forceRelaod();
          backToList(translations);
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteAxis(expo.axes[widget.axisId]!);
          expo.axes.remove(widget.axisId!);
          dataProvider.forceRelaod();
          backToList(translations);
        },
        hasDependencies: expo.events
                .where((event) => event.axis.id == widget.axisId)
                .isNotEmpty ||
            expo.objects
                .where((obj) => obj.axis.id == widget.axisId)
                .isNotEmpty,
      ),
    );
  }
}
