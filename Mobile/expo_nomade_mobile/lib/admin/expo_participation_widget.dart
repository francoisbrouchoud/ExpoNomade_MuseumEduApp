import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/util/container_admin_widget.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/globals.dart';

/// Class ExpoParticipationListWidget is used to list a collection of ExpoPopulationType. Inherits from BaseBOListWidget.
class ExpoParticipationListWidget extends StatelessWidget {
  final String title;
  final List<Participation> listableItems;

  /// Creates a new ExpoParticipationListWidget.
  ExpoParticipationListWidget({super.key, required BuildContext context})
      : title = AppLocalization.of(context).getTranslation("quiz_result_list"),
        listableItems = Provider.of<ExpositionNotifier>(context, listen: true)
            .exposition
            .quiz
            .participations
            .toList();

  @override
  Widget build(BuildContext context) {
    return ContainerAdminWidget(
      fixedContainerHeight: true,
      title: title,
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GlobalConstants.quizDefPaddingSize,
                  vertical: GlobalConstants.quizPageContMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalization.of(context).getTranslation("email"),
                      style: TextStyle(fontSize: 28.0)), // TODO Julienne
                  Text(AppLocalization.of(context).getTranslation("score"),
                      style: TextStyle(fontSize: 28.0)), // TODO Julienne
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listableItems.length,
                itemBuilder: (context, index) {
                  final item = listableItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: UnderlinedContainerWidget(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(item.email,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontSize: 22.0)), // TODO Julienne
                          ),
                          Text("${item.score}%",
                              style:
                                  TextStyle(fontSize: 22.0)), // TODO Julienne
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
