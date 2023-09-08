import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/bo_editor_block_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:flutter/material.dart';

/// Class MultilingualStringEditorWidget is used to display a list of TextFormFields for each language available in the application.
class MultilingualStringEditorWidget extends StatefulWidget {
  final String name;
  final MultilingualString? value;
  final Function(Map<String, String>) valueChanged;
  final bool mandatory;

  /// Creates a new MultilingualStringEditorWidget: the name will be displayed as a title and the generated fields will be filled with the value if provided. Every change will trigget the valueChanged callback.
  const MultilingualStringEditorWidget(
      {super.key,
      required this.name,
      required this.value,
      required this.valueChanged,
      this.mandatory = false});

  @override
  MultilingualStringEditorWidgetState createState() =>
      MultilingualStringEditorWidgetState();
}

/// State class for the MultilingualStringEditorWidget.
class MultilingualStringEditorWidgetState
    extends State<MultilingualStringEditorWidget> {
  late final Map<String, TextEditingController> _controllers;

  /// Gets the current values from the TextFormFields
  Map<String, String> _getCurrentValues() {
    return _controllers
        .map((lang, controller) => MapEntry(lang, controller.text));
  }

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var lang in AppLocalization.supportedLanguages)
        lang: TextEditingController(text: widget.value?[lang] ?? ''),
    };
    _controllers.forEach((lang, controller) {
      controller.addListener(() => widget.valueChanged(_getCurrentValues()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return BOEditorBlockWidget(
      name: widget.name,
      mandatory: widget.mandatory,
      children: [
        ...AppLocalization.supportedLanguages.map(
          (lang) => Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: GlobalConstants.multiTFFLabelMargin),
                child: Text(lang.toUpperCase()),
              ),
              Expanded(
                child: TextFormField(
                  controller: _controllers[lang],
                  decoration: InputDecoration(
                    labelText:
                        '${widget.name} (${translations.getTranslation('lang_$lang')})',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
