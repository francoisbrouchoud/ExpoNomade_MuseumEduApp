import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:flutter/material.dart';

/// Class UnderlinedContainerWidget is used to create a container underlined with a fixed border on the bottom with the color of the theme.
class UnderlinedContainerWidget extends StatelessWidget {
  final Widget content;

  /// Creates a new UnderlinedContainerWidget
  const UnderlinedContainerWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.secondary,
            width: GlobalConstants.ulcBottomBorderWidth,
          ),
        ),
      ),
      child: content,
    );
  }
}
