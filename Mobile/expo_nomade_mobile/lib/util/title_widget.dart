import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:flutter/material.dart';

/// Class TitleWidget is used to display a title in the style of the application.
class TitleWidget extends StatelessWidget {
  /// Creates a new TitleWidget.
  const TitleWidget({super.key, required this.text});

  final String text;

  /// Estimates the title's final height
  double estimateTitleHeight(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(
        maxWidth: MediaQuery.of(context).size.width * 0.7 -
            2 * GlobalConstants.titleWidgetContPadding);

    return textPainter.size.height +
        2 * GlobalConstants.titleWidgetContPadding +
        2 * GlobalConstants.titleWidgetContMargin;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final textStyle = theme.textTheme.titleLarge;
    return Container(
      width: screenWidth * GlobalConstants.defaultWidgetWidthMult,
      margin: const EdgeInsets.symmetric(
          vertical: GlobalConstants.titleWidgetContMargin),
      padding: const EdgeInsets.all(GlobalConstants.titleWidgetContPadding),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(GlobalConstants.defaultBorderRadius),
        color: theme.colorScheme.background,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(GlobalConstants.titleWidgetTextPad),
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
