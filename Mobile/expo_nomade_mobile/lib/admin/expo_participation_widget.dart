import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/bo/paticipation.dart';
import 'package:expo_nomade_mobile/util/container_admin_widget.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/globals.dart';

class ExpoParticipationTypeListWidget extends StatelessWidget {
  final String title;
  final List<Participation> listableItems;

  ExpoParticipationTypeListWidget({required BuildContext context})
      : this.title =
            AppLocalization.of(context).getTranslation("quiz_result_list"),
        this.listableItems =
            Provider.of<ExpositionNotifier>(context, listen: true)
                .exposition
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalization.of(context).getTranslation("email"),
                      style: TextStyle(fontSize: 28.0)),
                  Text(AppLocalization.of(context).getTranslation("score"),
                      style: TextStyle(fontSize: 28.0)),
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
                                style: TextStyle(fontSize: 22.0)),
                          ),
                          Text(item.score.toString() + "%",
                              style: TextStyle(fontSize: 22.0)),
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
