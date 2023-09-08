import 'package:flutter/material.dart';

import '../helper/globals.dart';

/// Enum ButtonWidgetType defines every type of button available in the application.
enum ButtonWidgetType { standard, home, delete }

/// Contains the design of a button using the application's theme according to it's type.
class ButtonWidget extends StatelessWidget {
  /// Creates a new ButtonWidget
  const ButtonWidget(
      {super.key,
      required this.text,
      required this.action,
      required this.type});

  final String text;
  final Function()? action;
  final ButtonWidgetType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    dynamic btnTextStyle;
    dynamic bgCol = theme.colorScheme.background;
    switch (type) {
      case ButtonWidgetType.standard:
        bgCol = theme.colorScheme.secondary;
        btnTextStyle = theme.textTheme.displaySmall!
            .copyWith(color: theme.colorScheme.background);
        break;
      case ButtonWidgetType.home:
        bgCol = theme.colorScheme.background;
        btnTextStyle = theme.textTheme.displayMedium!.copyWith(
          color: theme.colorScheme.secondary,
        );
        break;
      case ButtonWidgetType.delete:
        bgCol = theme.colorScheme.error;
        btnTextStyle = theme.textTheme.displaySmall!
            .copyWith(color: theme.colorScheme.background);
        break;
      default:
      // unused
    }
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgCol,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: GlobalConstants.appBtnVertPadding,
                horizontal: GlobalConstants.appBtnHorzPadding),
            child: Text(text, style: btnTextStyle)));
  }
}
