import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.text});

  final String text;
  final contMargin = 8.0;
  final contPadding = 12.0;
  final borderRad = 16.0;
  final paddingPadding = 10.0;

  double estimateTitleHeight(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(
        maxWidth: MediaQuery.of(context).size.width * 0.7 - 2 * contPadding);

    return textPainter.size.height + 2 * contPadding + 2 * contMargin;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.secondary,
    );
    return Container(
      width: screenWidth * 0.7,
      margin: EdgeInsets.symmetric(vertical: contMargin),
      padding: EdgeInsets.all(contPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRad),
        color: theme.colorScheme.background,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingPadding),
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
