import 'dart:collection';

import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../bo/exposition.dart';
import '../firebase_service.dart';
import '../util/base_bo_editor_widget.dart';
import '../util/globals.dart';
import '../util/multilingual_string.dart';
import '../util/multilingual_string_editor.dart';

/// Class ExpoPopulationTypeEditorWidget is a widget used to edit or create an ExpoPopulationType object.
class ExpoPopulationTypeEditorWidget extends StatefulWidget {
  final String? popTypeId;

  /// ExpoPopulationTypeEditorWidget constructor.
  const ExpoPopulationTypeEditorWidget({super.key, this.popTypeId});

  @override
  _ExpoPopulationTypeEditorWidgetState createState() =>
      _ExpoPopulationTypeEditorWidgetState();
}

/// State class for the ExpoPopulationTypeEditorWidget.
class _ExpoPopulationTypeEditorWidgetState
    extends State<ExpoPopulationTypeEditorWidget> {
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

    Map<String, String> newTitleVals = widget.popTypeId != null
        ? expo.populationTypes[widget.popTypeId!]!.title.toMap()
        : HashMap();
    final titleWidget = MultilingualStringEditorWidget(
      name: title,
      value: widget.popTypeId != null
          ? expo.populationTypes[widget.popTypeId!]!.title
          : null,
      valueChanged: (newVals) => newTitleVals = newVals,
    );
    return Material(
      child: BaseBOEditorWidget(
        title: widget.popTypeId != null
            ? translations.getTranslation("population_type_edit")
            : translations.getTranslation("population_type_creation"),
        content: [
          titleWidget,
        ],
        object: widget.popTypeId != null
            ? expo.populationTypes[widget.popTypeId!]
            : null,
        itemSaveRequested: () async {
          ExpoPopulationType popType =
              ExpoPopulationType("", MultilingualString(newTitleVals));
          if (widget.popTypeId != null) {
            popType = expo.populationTypes[widget.popTypeId]!;
            popType.title = MultilingualString(newTitleVals);
          }
          if (popType.id.isNotEmpty) {
            await FirebaseService.updatePopulationType(popType);
          } else {
            ExpoPopulationType? newPopType =
                await FirebaseService.createPopulationType(popType);
            if (newPopType != null) {
              expo.populationTypes.putIfAbsent(newPopType.id, () => newPopType);
            }
          }
          dataProvider.forceRelaod();
          backToList(translations);
        },
        itemDeleteRequested: () async {
          await FirebaseService.deletePopulationType(
              expo.populationTypes[widget.popTypeId]!);
          expo.populationTypes.remove(widget.popTypeId!);
          dataProvider.forceRelaod();
          backToList(translations);
        },
        hasDependencies: expo.events
            .where((event) => event.populationType.id == widget.popTypeId)
            .isNotEmpty,
      ),
    );
  }
}
