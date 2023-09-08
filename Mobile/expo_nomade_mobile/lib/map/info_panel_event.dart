import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:flutter/material.dart';
import 'package:expo_nomade_mobile/util/globals.dart';

class InfoPanelEvent extends StatelessWidget {
  final ExpoEvent event;
  final VoidCallback onClose;

  const InfoPanelEvent({
    Key? key,
    required this.event,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();

    return Container(
      height: screenHeight,
      color: theme.colorScheme.primary, // Set your desired background color
      padding: const EdgeInsets.all(32), // Add internal padding
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Text(
              event.title[langCode],
              style: const TextStyle(
                fontSize: 24, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            if (event.pictureURL != '')
              SizedBox(
                child: Image.network(event.pictureURL),
                height: GlobalConstants.imagesDefaultDimension,
              ),

            const SizedBox(
                height: GlobalConstants.infoPanelsMediumSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('reason')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(event.reason[langCode]),
              ],
            ),

            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('population_type')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(event.populationType.title[langCode]),
              ],
            ),

            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(children: [
              Text(
                '${translations.getTranslation('years')} : ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(event.startYear.toString()),
              Text(" - "),
              Text(event.endYear.toString()),
            ]),

            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Text(event.description[langCode]),
          ],
        ),
      ),
    );
  }
}
