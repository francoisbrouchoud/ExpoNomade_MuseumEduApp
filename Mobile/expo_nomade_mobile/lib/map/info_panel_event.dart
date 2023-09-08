import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_event.dart';
import 'package:flutter/material.dart';
import 'package:expo_nomade_mobile/util/globals.dart';

// This class display all the information we want from an Event in our database
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
    final titleStyle = theme.textTheme.displayMedium!.copyWith(
      fontWeight: FontWeight.bold,
    );
    final textStyle = theme.textTheme.displaySmall!;
    final labelStyle = theme.textTheme.displaySmall!.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Container(
      height: screenHeight,
      // We set the color of the container by using the theme we created
      color: theme.colorScheme.primary,
      // The padding is also defined with global constants
      padding: const EdgeInsets.all(GlobalConstants.infoPanelsPadding),
      // The SingleChildScrollView allows us to have an adaptative length for the container with our data
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

            // Title of the event
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Text(
              event.title[langCode],
              style: titleStyle,
            ),
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing

            // Image of the event
            if (event.pictureURL != '')
              SizedBox(
                height: GlobalConstants.imagesDefaultDimension,
                child: Image.network(event.pictureURL),
              ),

            // Reason of the Event
            const SizedBox(
                height: GlobalConstants.infoPanelsMediumSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('reason')} : ',
                  style: labelStyle,
                ),
                Text(event.reason[langCode], style: textStyle),
              ],
            ),

            // The type of population of the Event
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('population_type')} : ',
                  style: labelStyle,
                ),
                Text(event.populationType.title[langCode], style: textStyle),
              ],
            ),

            // The years of the Event
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(children: [
              Text(
                '${translations.getTranslation('years')} : ',
                style: labelStyle,
              ),
              Text(event.startYear.toString(), style: textStyle),
              Text(" - ", style: textStyle),
              Text(event.endYear.toString(), style: textStyle),
            ]),

            // The description of the Event
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Text(event.description[langCode], style: textStyle),
          ],
        ),
      ),
    );
  }
}
