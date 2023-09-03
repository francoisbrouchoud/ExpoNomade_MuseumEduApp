import 'package:expo_nomade_mobile/util/title_widget.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      required this.title,
      required this.body,
      this.isAdmin = false});

  final String title;
  final Widget body;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor:
            isAdmin ? theme.colorScheme.tertiary : theme.colorScheme.primary,
        body: Center(
            child: Column(children: [
          const SizedBox(height: 60),
          TitleWidget(text: title),
          const SizedBox(height: 30),
          Container(
              width: screenWidth * 0.7,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.colorScheme.background,
              ),
              child: Center(
                  child:
                      Padding(padding: const EdgeInsets.all(10), child: body)))
        ])));
  }
}
