import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/widgets/simple_snack_bar.dart';
import 'package:expo_nomade_mobile/helper/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/app_localization.dart';
import '../bo/exposition.dart';
import '../helper/firebase_service.dart';
import '../widgets/base_bo_editor_widget.dart';
import '../helper/notifer_helper.dart';
import '../helper/multilingual_string.dart';
import '../widgets/multilingual_string_editor_widget.dart';

/// Class ExpoPopulationTypeEditorWidget is a widget used to edit or create an ExpoPopulationType object.
class ExpoPopulationTypeEditorWidget extends StatefulWidget {
  final ExpoPopulationType? populationType;

  /// ExpoPopulationTypeEditorWidget constructor.
  const ExpoPopulationTypeEditorWidget({super.key, this.populationType});

  @override
  ExpoPopulationTypeEditorWidgetState createState() =>
      ExpoPopulationTypeEditorWidgetState();
}

/// State class for the ExpoPopulationTypeEditorWidget.
class ExpoPopulationTypeEditorWidgetState
    extends State<ExpoPopulationTypeEditorWidget> {
  @override
  void initState() {
    super.initState();
  }

  /// Navigates back to the list view.
  void backToList({String? text}) {
    if (text != null) {
      SimpleSnackBar.showSnackBar(context, text);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final dataProvider = Provider.of<ExpositionNotifier>(context);
    final Exposition expo = dataProvider.exposition;
    Map<String, String> newTitleVals =
        widget.populationType?.title.toMap() ?? {};
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
          if (!ValidationHelper.isEmptyTranslationMap(newTitleVals)) {
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
            backToList(text: translations.getTranslation("saved"));
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
