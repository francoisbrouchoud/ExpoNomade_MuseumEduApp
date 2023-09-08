import 'package:expo_nomade_mobile/helper/globals.dart';
import 'package:expo_nomade_mobile/widgets/title_widget.dart';
import 'package:flutter/material.dart';

/// Class ContainerWidget is a container designed in the style of the application.
class ContainerWidget extends StatelessWidget {
  /// Creates a new ContainerWidget
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
                  GlobalConstants.cwBefTitlePHH -
                  titleWidget.estimateTitleHeight(context) -
                  GlobalConstants.cwAftTitlePHH -
                  2 * GlobalConstants.cwContMargin -
                  2 * GlobalConstants.cwContPadding -
                  GlobalConstants.cwBefTitlePHH;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: GlobalConstants.cwBefTitlePHH),
                titleWidget,
                const SizedBox(height: GlobalConstants.cwAftTitlePHH),
                Container(
                  width: screenWidth * GlobalConstants.defaultWidgetWidthMult,
                  height: contHeight,
                  margin: const EdgeInsets.symmetric(
                      vertical: GlobalConstants.cwContMargin),
                  padding: const EdgeInsets.all(GlobalConstants.cwContPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        GlobalConstants.defaultBorderRadius),
                    color: theme.colorScheme.background,
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(GlobalConstants.cwBodyPadding),
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
