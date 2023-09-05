import 'dart:collection';

import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:expo_nomade_mobile/util/validation_helper.dart';
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
  final ExpoPopulationType? populationType;

  /// ExpoPopulationTypeEditorWidget constructor.
  const ExpoPopulationTypeEditorWidget({super.key, this.populationType});

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
  void backToList() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<DataNotifier>(context);
    final Exposition expo = dataProvider.exposition;
    Map<String, String> newTitleVals =
        widget.populationType?.title.toMap() ?? HashMap();
    return Material(
      child: BaseBOEditorWidget(
        title: widget.populationType != null
            ? translations.getTranslation("population_type_edit")
            : translations.getTranslation("population_type_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("title"),
            value: widget.populationType?.title,
            valueChanged: (newVals) => newTitleVals = newVals,
            mandatory: true,
          ),
        ],
        object: widget.populationType,
        itemSaveRequested: () async {
          if (!isEmptyTranslationMap(newTitleVals)) {
            ExpoPopulationType popType =
                ExpoPopulationType("", MultilingualString(newTitleVals));
            if (widget.populationType != null) {
              popType = widget.populationType!;
              popType.title = MultilingualString(newTitleVals);
              await FirebaseService.updatePopulationType(popType);
            } else {
              ExpoPopulationType? newPopType =
                  await FirebaseService.createPopulationType(popType);
              if (newPopType != null) {
                expo.populationTypes
                    .putIfAbsent(newPopType.id, () => newPopType);
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
          await FirebaseService.deletePopulationType(widget.populationType!);
          expo.populationTypes.remove(widget.populationType!);
          dataProvider.forceRelaod();
          backToList();
        },
        hasDependencies: expo.events
            .where(
                (event) => event.populationType.id == widget.populationType?.id)
            .isNotEmpty,
      ),
    );
  }
}
