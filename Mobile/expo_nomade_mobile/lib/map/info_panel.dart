import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';

/// Class InfoPanel is used to display information about a marker.
class InfoPanel extends StatelessWidget {
  final ExpoObject object;
  final VoidCallback onClose;

  const InfoPanel({
    Key? key,
    required this.object,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();
    return Container(
      // TODO set theme bg color
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          //Text('Marker id: $markerId'),
          // ICI LE TEXTE DOIT ÊTRE TABLEAUDOBJET[NUMéROD'INDEX].TITLE[LANGCODE]

          Text(object.title[langCode]),
          Text(object.description[langCode])
          // TODO add info contained in marker!
          // TODO ensure this container is scrollable
        ],
      ),
    );
  }
}
