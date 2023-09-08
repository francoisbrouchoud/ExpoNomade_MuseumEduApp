import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';
import 'package:expo_nomade_mobile/util/globals.dart';

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
      color: theme.colorScheme.primary, // Set your desired background color
      padding: const EdgeInsets.all(
          GlobalConstants.infoPanelsPadding), // Add internal padding
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
              object.title[langCode],
              style: titleStyle,
            ),
            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            SizedBox(
              child: Image.network(object.pictureURL),
              height: GlobalConstants.imagesDefaultDimension,
            ),

            const SizedBox(
                height: GlobalConstants.infoPanelsMediumSpacing), // Add spacing
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

            const SizedBox(
                height: GlobalConstants.infoPanelsSmallSpacing), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('museum')} : ',
                  style: labelStyle,
                ),
                Text(object.museum.name[langCode], style: textStyle),
              ],
            ),

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

            const SizedBox(height: 20), // Add spacing
            Text(object.description[langCode], style: textStyle),
          ],
        ),
      ),
    );
  }
}
