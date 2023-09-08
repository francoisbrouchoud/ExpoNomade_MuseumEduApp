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
            const SizedBox(height: 10), // Add spacing
            Text(
              object.title[langCode],
              style: const TextStyle(
                fontSize: 24, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Add spacing
            SizedBox(
              child: Image.network(object.pictureURL),
              height: GlobalConstants.imagesDefaultDimension,
            ),

            const SizedBox(height: 20), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('year')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.coordinates.keys.first.toString()),
              ],
            ),

            const SizedBox(height: 10), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('museum')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.museum.name[langCode]),
              ],
            ),

            const SizedBox(height: 10), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('position')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.position[langCode]),
              ],
            ),

            const SizedBox(height: 10), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('dimensions')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.dimension),
              ],
            ),

            const SizedBox(height: 10), // Add spacing
            Row(
              children: [
                Text(
                  '${translations.getTranslation('material')} : ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(object.material[langCode]),
              ],
            ),

            const SizedBox(height: 20), // Add spacing
            Text(object.description[langCode]),
          ],
        ),
      ),
    );
  }
}
