import 'dart:collection';
import 'dart:ui';

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_axis.dart';
import 'package:expo_nomade_mobile/bo/expo_population_type.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/base_bo_editor_widget.dart';
import 'package:expo_nomade_mobile/util/bo_selector_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:expo_nomade_mobile/util/latlng_selector_widget.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/multilingual_string_editor.dart';
import 'package:expo_nomade_mobile/util/year_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bo/expo_event.dart';
import 'package:latlong2/latlong.dart';

/// Class ExpoEventEditorWidget is a widget used to edit or create an ExpoEvent object.
class ExpoEventEditorWidget extends StatefulWidget {
  final ExpoEvent? event;

  /// ExpoEventEditorWidget constructor.
  const ExpoEventEditorWidget({super.key, this.event});

  @override
  _ExpoEventEditorWidgetState createState() => _ExpoEventEditorWidgetState();
}

/// State class for the ExpoEventEditorWidget.
class _ExpoEventEditorWidgetState extends State<ExpoEventEditorWidget> {
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
    final dataProvider = Provider.of<DataNotifier>(context);
    final exposition = dataProvider.exposition;
    Map<String, String> newTitleVals = widget.event?.title.toMap() ?? HashMap();
    Map<String, String> newDescVals =
        widget.event?.description.toMap() ?? HashMap();
    Map<String, String> newReasVals = widget.event?.reason.toMap() ?? HashMap();
    ExpoAxis newAxisVal = widget.event?.axis ?? exposition.axes.values.first;
    ExpoPopulationType newPopTypeVal =
        widget.event?.populationType ?? exposition.populationTypes.values.first;
    int newStartYearVal = widget.event?.startYear ?? DateTime.now().year;
    int newEndYearVal = widget.event?.endYear ?? DateTime.now().year;
    List<LatLng> newFromVals = widget.event?.from ?? [];
    List<LatLng> newToVals = widget.event?.to ?? [];
    Picture? newPicVal = null;
    return Material(
      child: BaseBOEditorWidget(
        title: widget.event != null
            ? translations.getTranslation("event_edit")
            : translations.getTranslation("event_creation"),
        content: [
          MultilingualStringEditorWidget(
            name: translations.getTranslation("title"),
            value: widget.event != null ? widget.event!.title : null,
            valueChanged: (newVals) => newTitleVals = newVals,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("description"),
            value: widget.event != null ? widget.event!.description : null,
            valueChanged: (newVals) => newDescVals = newVals,
          ),
          MultilingualStringEditorWidget(
            name: translations.getTranslation("reason"),
            value: widget.event != null ? widget.event!.reason : null,
            valueChanged: (newVals) => newReasVals = newVals,
          ),
          BOSelectorWidget(
            name: translations.getTranslation("axe"),
            preSel: newAxisVal,
            objects: exposition.axes.values.toList(),
            selectedItemChanged: (newVal) => newAxisVal = (newVal as ExpoAxis),
          ),
          BOSelectorWidget(
            name: translations.getTranslation("population_type"),
            preSel: newPopTypeVal,
            objects: exposition.populationTypes.values.toList(),
            selectedItemChanged: (newVal) =>
                newPopTypeVal = (newVal as ExpoPopulationType),
          ),
          YearSelectorWidget(
            name: translations.getTranslation("start_year"),
            selectedYearChanged: (newVal) => newStartYearVal = newVal,
            selectedYear: newStartYearVal,
          ),
          YearSelectorWidget(
            name: translations.getTranslation("end_year"),
            selectedYear: newEndYearVal,
            selectedYearChanged: (newVal) => newEndYearVal = newVal,
          ),
          LatLngSelectorWidget(
            name: translations.getTranslation("coordinates_from"),
            values: newFromVals,
            valuesChanged: (newVals) => newFromVals = newVals,
          ),
          LatLngSelectorWidget(
            name: translations.getTranslation("coordinates_to"),
            values: newToVals,
            valuesChanged: (newVals) => newToVals = newVals,
          ),
        ],
        object: widget.event,
        itemSaveRequested: () async {
          ExpoEvent event = ExpoEvent(
              "",
              newAxisVal,
              MultilingualString(newDescVals),
              newEndYearVal,
              newFromVals,
              newPicVal,
              newPopTypeVal,
              MultilingualString(newReasVals),
              newStartYearVal,
              MultilingualString(newTitleVals),
              newToVals);
          if (widget.event != null) {
            event = widget.event!;
            event.title = MultilingualString(newTitleVals);
            event.description = MultilingualString(newDescVals);
            event.reason = MultilingualString(newReasVals);
            event.axis = newAxisVal;
            event.populationType = newPopTypeVal;
            event.startYear = newStartYearVal;
            event.endYear = newEndYearVal;
            event.from = newFromVals;
            event.to = newToVals;
            event.picture = newPicVal;
            await FirebaseService.updateEvent(event);
          } else {
            ExpoEvent? newEvent = await FirebaseService.createEvent(event);
            if (newEvent != null) {
              exposition.events.add(newEvent);
            }
          }
          dataProvider.forceRelaod();
          backToList(translations);
        },
        itemDeleteRequested: () async {
          await FirebaseService.deleteEvent(widget.event!);
          exposition.events.remove(widget.event!);
          dataProvider.forceRelaod();
          backToList(translations);
        },
      ),
    );
  }
}
