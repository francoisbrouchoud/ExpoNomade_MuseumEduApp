import 'package:flutter/material.dart';

enum ButtonWidgetType { standard, home, delete }

/// Contain the design of a main button
class ButtonWidget extends StatelessWidget {
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(text, style: btnTextStyle)));
  }
}
