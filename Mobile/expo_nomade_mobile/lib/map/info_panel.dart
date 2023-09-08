import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';
import 'package:expo_nomade_mobile/util/globals.dart';

// This class display all the information we want from an Object in our database
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
    double screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    final langCode = translations.getCurrentLangCode();

    return Container(
      height: screenHeight,
      // We set the color of the container by using the theme we created
      color: theme.colorScheme.primary,
      padding: const EdgeInsets.all(
          // The padding is also defined with global constants
          GlobalConstants.infoPanelsPadding),
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

            // Title of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Text(
              object.title[langCode],
              style: const TextStyle(
                fontSize: 24, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),

            // Image of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            SizedBox(
              height: GlobalConstants.imagesDefaultDimension,
              child: Image.network(object.pictureURL),
            ),

            // The year of the object
            const SizedBox(height: GlobalConstants.infoPanelsMediumSpacing),
            Row(
              children: [
                Text(
                  '${translations.getTranslation('year')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.coordinates.keys.first.toString()),
              ],
            ),

            // The name of the museum where the object is stored
            const SizedBox(height: GlobalConstants.infoPanelsSmallSpacing),
            Row(
              children: [
                Text(
                  '${translations.getTranslation('museum')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.museum.name[langCode]),
              ],
            ),

            // The current location of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('position')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.position[langCode]),
              ],
            ),

            // The dimensions of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('dimensions')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.dimension),
              ],
            ),

            // The material which compose the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('material')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.material[langCode]),
              ],
            ),

            // The description of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsMediumSpacing), // Add spacing
            Text(object.description[langCode]),
          ],
        ),
      ),
    );
  }
}
