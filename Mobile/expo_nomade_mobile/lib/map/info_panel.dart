import 'package:expo_nomade_mobile/helper/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';
import 'package:expo_nomade_mobile/helper/globals.dart';

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

            // Title of the object
            const SizedBox(height: GlobalConstants.infoPanelsSmallSpacing),
            Text(
              object.title[langCode],
              style: titleStyle,
            ),
            const SizedBox(height: GlobalConstants.infoPanelsSmallSpacing),

            // Image of the object
            if (object.pictureURL != '')
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
                  style: labelStyle,
                ),
                Text(object.coordinates.keys.first.toString(),
                    style: textStyle),
              ],
            ),

            // The name of the museum where the object is stored
            const SizedBox(height: GlobalConstants.infoPanelsSmallSpacing),
            Row(
              children: [
                Text(
                  '${translations.getTranslation('museum')} : ',
                  style: labelStyle,
                ),
                Text(object.museum.name[langCode], style: textStyle),
              ],
            ),

            // The current location of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('position')} : ',
                  style: labelStyle,
                ),
                Text(object.position[langCode], style: textStyle),
              ],
            ),

            // The dimensions of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('dimensions')} : ',
                  style: labelStyle,
                ),
                Text(object.dimension, style: textStyle),
              ],
            ),

            // The material which compose the object
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('material')} : ',
                  style: labelStyle,
                ),
                Text(object.material[langCode], style: textStyle),
              ],
            ),

            // The description of the object
            const SizedBox(
                height: GlobalConstants.infoPanelsMediumSpacing), // Add spacing
            Text(object.description[langCode], style: textStyle),
          ],
        ),
      ),
    );
  }
}
