import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/expo_object.dart';
import 'package:flutter/material.dart';

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
      color: Colors.white, // Set your desired background color
      margin: EdgeInsets.all(16.0), // Add margins
      padding: EdgeInsets.all(16.0), // Add internal padding
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
            SizedBox(height: 20), // Add spacing
            Text(
              object.title[langCode],
              style: TextStyle(
                fontSize: 24, // Increase font size
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Add spacing
            Text(object.description[langCode]),
          ],
        ),
      ),
    );
  }
}
