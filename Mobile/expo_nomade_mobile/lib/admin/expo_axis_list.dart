import 'package:expo_nomade_mobile/admin/expo_axis_editor.dart';
import 'package:expo_nomade_mobile/bo/exposition.dart';
import 'package:flutter/material.dart';

import '../app_localization.dart';

/// Class ExpoAxisListWidget is a widget used to list all ExpoAxes or add a new one.
class ExpoAxisListWidget extends StatefulWidget {
  final Exposition exposition;

  /// ExpoAxisListWidget constructor.
  const ExpoAxisListWidget({
    super.key,
    required this.exposition,
  });

  @override
  _ExpoAxisListWidgetState createState() => _ExpoAxisListWidgetState();
}

/// State class for the ExpoAxisListWidget.
class _ExpoAxisListWidgetState extends State<ExpoAxisListWidget> {
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    return Material(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ExpoAxisEditorWidget(exposition: widget.exposition)));
            },
            child: Text(translations.getTranslation("add")),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.exposition.axes.length,
              itemBuilder: (context, index) {
                final expoAxisKey =
                    widget.exposition.axes.keys.elementAt(index);
                final expoAxis = widget.exposition.axes[expoAxisKey]!;
                final title = expoAxis.title[translations.getCurrentLangCode()];
                return ListTile(
                  title: Text(title),
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ExpoAxisEditorWidget(
                          exposition: widget.exposition,
                          axisId: expoAxisKey,
                        ),
                      ),
                    );
                    if (result == true) {
                      setState(() {}); // to rebuild the list
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
