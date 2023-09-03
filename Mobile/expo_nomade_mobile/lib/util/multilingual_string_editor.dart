import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/multilingual_string.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/material.dart';

/// Class MultilingualStringEditorWidget is used to display a list of TextFormFields for each language available in the application.
class MultilingualStringEditorWidget extends StatefulWidget {
  final String name;
  final MultilingualString? value;
  final Function(Map<String, String>) valueChanged;

  /// Creates a new MultilingualStringEditorWidget: the name will be displayed as a title and the generated fields will be filled with the value if provided. Every change will trigget the valueChanged callback.
  const MultilingualStringEditorWidget(
      {super.key,
      required this.name,
      required this.value,
      required this.valueChanged});

  @override
  _MultilingualStringEditorWidgetState createState() =>
      _MultilingualStringEditorWidgetState();
}

/// State class for the MultilingualStringEditorWidget.
class _MultilingualStringEditorWidgetState
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
    const labelMargin = 20.0;
    const containerMargin = 15.0;
    final translations = AppLocalization.of(context);
    return UnderlinedContainerWidget(
      content: Column(
        children: [
          const SizedBox(height: containerMargin),
          Row(
            children: [
              Text(widget.name),
            ],
          ),
          ...AppLocalization.supportedLanguages.map(
            (lang) => Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: labelMargin),
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
          const SizedBox(height: containerMargin)
        ],
      ),
    );
  }
}
