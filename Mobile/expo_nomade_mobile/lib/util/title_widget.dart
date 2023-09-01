import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        width: screenWidth * 0.7,
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: theme.colorScheme.background,
        ),
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(text,
                    style: TextStyle(
                        color: theme.colorScheme.secondary, fontSize: 48)))));
  }
}
