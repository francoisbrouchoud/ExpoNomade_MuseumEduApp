import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:flutter/material.dart';

/// SimpleSnackBar class is used to define quickly usable methods to display simple SnackBars
class SimpleSnackBar {
  /// Shows a SnackBar during a fixed duration of 3 seconds containing the message provided. Closes on click on the "OK" button.
  static void showSnackBar(BuildContext context, String message) {
    const duration = 3;
    final sb = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: duration),
      action: SnackBarAction(
        label: GlobalConstants.okMsg,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }
}
