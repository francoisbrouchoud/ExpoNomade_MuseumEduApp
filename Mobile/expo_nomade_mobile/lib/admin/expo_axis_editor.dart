import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:flutter/material.dart';

import '../bo/expo_axis.dart';

/// Class ExpoAxisEditorWidget is a widget used to edit or create an ExpoAxis object.
class ExpoAxisEditorWidget extends StatefulWidget {
  final Exposition exposition;
  final String? axisId;

  /// ExpoAxisEditorWidget constructor.
  const ExpoAxisEditorWidget(
      {super.key, required this.exposition, this.axisId});

  @override
  _ExpoAxisEditorWidgetState createState() => _ExpoAxisEditorWidgetState();
}

/// State class for the ExpoAxisEditorWidget.
class _ExpoAxisEditorWidgetState extends State<ExpoAxisEditorWidget> {
  final Map<String, TextEditingController> _titleControllers = {
    for (var e in AppLocalization.supportedLanguages) e: TextEditingController()
  };
  final Map<String, TextEditingController> _descControllers = {
    for (var e in AppLocalization.supportedLanguages) e: TextEditingController()
  };

  @override
  void initState() {
    super.initState();
    if (widget.axisId != null) {
      _titleControllers.forEach((lang, controller) {
        controller.text = widget.exposition.axes[widget.axisId]!.title[lang];
      });
      _descControllers.forEach((lang, controller) {
        controller.text =
            widget.exposition.axes[widget.axisId]!.description[lang];
      });
    }
  }

  /// Navigates back to the list view.
  void backToList() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final title = translations.getTranslation("title");
    final description = translations.getTranslation("description");
    return Material(
      child: Column(
        children: [
          Column(
            children: AppLocalization.supportedLanguages.map((lang) {
              return TextFormField(
                controller: _titleControllers[lang],
                decoration: InputDecoration(labelText: '$title ($lang)'),
              );
            }).toList(),
          ),
          Column(
            children: AppLocalization.supportedLanguages.map((lang) {
              return TextFormField(
                controller: _descControllers[lang],
                decoration: InputDecoration(labelText: '$description ($lang)'),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, String> description = {
                for (var e in _descControllers.entries) e.key: e.value.text
              };
              Map<String, String> title = {
                for (var e in _titleControllers.entries) e.key: e.value.text
              };
              ExpoAxis axis = ExpoAxis("", MultilingualString(description),
                  MultilingualString(title));
              if (widget.axisId != null) {
                axis = widget.exposition.axes[widget.axisId]!;
                axis.title = MultilingualString(title);
                axis.description = MultilingualString(description);
              }
              if (axis.id.isNotEmpty) {
                await FirebaseService.updateAxis(axis);
              } else {
                ExpoAxis? newAxis = await FirebaseService.createAxis(axis);
                if (newAxis != null) {
                  widget.exposition.axes.putIfAbsent(newAxis.id, () => newAxis);
                }
              }
              backToList();
            },
            child: Text(translations.getTranslation("save")),
          ),
          if (widget.axisId != null)
            ElevatedButton(
              onPressed: () async {
                widget.exposition.axes.remove(widget.axisId!);
                await FirebaseService.deleteAxis(
                    widget.exposition.axes[widget.axisId]!);
                backToList();
              },
              child: Text(translations.getTranslation("delete")),
            ),
        ],
      ),
    );
  }
}
