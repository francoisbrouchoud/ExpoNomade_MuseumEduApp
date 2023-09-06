import 'dart:collection';

import 'package:expo_nomade_mobile/util/simple_snack_bar.dart';
import 'package:expo_nomade_mobile/util/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_localization.dart';
import '../bo/expo_name.dart';
import '../firebase_service.dart';
import '../util/base_bo_editor_widget.dart';
import '../util/globals.dart';
import '../util/multilingual_string.dart';
import '../util/multilingual_string_editor.dart';

/// Class ExpoEditorWidget is a widget used to edit or create an ExpoPopulationType object.
class ExpoEditorWidget extends StatefulWidget {
  final ExpoName? expo;

  /// ExpoEditorWidget constructor.
  const ExpoEditorWidget({super.key, this.expo});

  @override
  _ExpoEditorWidgetState createState() => _ExpoEditorWidgetState();
}

/// State class for the ExpoEditorWidget.
class _ExpoEditorWidgetState extends State<ExpoEditorWidget> {
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
    final expos = dataProvider.expositions;
    final expo = dataProvider.exposition;
    Map<String, String> newTitleVals = widget.expo?.name.toMap() ?? HashMap();
    return Material(
      child: BaseBOEditorWidget(
          title: widget.expo != null
              ? translations.getTranslation("expo_edit")
              : translations.getTranslation("expo_creation"),
          content: [
            MultilingualStringEditorWidget(
              name: translations.getTranslation("name"),
              value: widget.expo?.name,
              valueChanged: (newVals) => newTitleVals = newVals,
              mandatory: true,
            ),
          ],
          object: widget.expo,
          itemSaveRequested: () async {
            if (!ValidationHelper.isEmptyTranslationMap(newTitleVals)) {
              ExpoName expoName =
                  ExpoName("", MultilingualString(newTitleVals));
              if (widget.expo != null) {
                expoName = widget.expo!;
                expo.name = MultilingualString(newTitleVals);
                await FirebaseService.updateExposition(expoName);
              } else {
                ExpoName? newexpo =
                    await FirebaseService.createExposition(expoName);
                if (newexpo != null) {
                  expos.putIfAbsent(newexpo.id, () => newexpo);
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
            await FirebaseService.deleteExposition(widget.expo!);
            expos.remove(widget.expo!.id);
            dataProvider.forceRelaod();
            backToList();
          },
          hasDependencies:
              widget.expo != null && expo.name == widget.expo!.name),
    );
  }
}
