import 'package:expo_nomade_mobile/util/title_widget.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      required this.title,
      required this.body,
      this.fixedContainerHeight = false,
      this.isAdmin = false});

  final String title;
  final Widget body;
  final bool fixedContainerHeight;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    const befTitlePlaceHolderH = 60.0;
    const aftTitlePlaceHolderH = 30.0;
    const contMargin = 8.0;
    const contPadding = 12.0;
    const borderRad = 16.0;
    const bodyPadding = 10.0;
    final titleWidget = TitleWidget(text: title);
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          isAdmin ? theme.colorScheme.tertiary : theme.colorScheme.primary,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = constraints.maxHeight;
            double? contHeight;
            if (fixedContainerHeight) {
              contHeight = maxHeight -
                  befTitlePlaceHolderH -
                  titleWidget.estimateTitleHeight(context) -
                  aftTitlePlaceHolderH -
                  2 * contMargin -
                  2 * contPadding -
                  befTitlePlaceHolderH;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: befTitlePlaceHolderH),
                titleWidget,
                const SizedBox(height: aftTitlePlaceHolderH),
                Container(
                  width: screenWidth * 0.7,
                  height: contHeight,
                  margin: const EdgeInsets.symmetric(vertical: contMargin),
                  padding: const EdgeInsets.all(contPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRad),
                    color: theme.colorScheme.background,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(bodyPadding),
                      child: body,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
