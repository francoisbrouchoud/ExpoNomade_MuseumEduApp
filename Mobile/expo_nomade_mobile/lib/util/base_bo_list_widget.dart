import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/base_business_object.dart';
import 'package:expo_nomade_mobile/util/underlined_container_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'container_admin_widget.dart';

/// Abstract class BaseBOListWidget is a widget used to list a collection of business objects.
abstract class BaseBOListWidget extends StatelessWidget {
  /// Creates a new BaseBOListWidget, must be called from a class inheriting from this one.
  const BaseBOListWidget(
      {super.key,
      required this.title,
      required this.listableItems,
      required this.itemTap,
      required this.itemAddRequested,
      required this.addButtonText});

  final String title;
  final List<BaseBusinessObject> listableItems;
  final Function(BaseBusinessObject) itemTap;
  final VoidCallback itemAddRequested;
  final String addButtonText;

  @override
  Widget build(BuildContext context) {
    const iconDim = 24.0; // edit icon fixed dimensions
    final translations = AppLocalization.of(context);
    return ContainerAdminWidget(
      fixedContainerHeight: true,
      title: title,
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listableItems.length,
                itemBuilder: (context, index) {
                  final item = listableItems[index];
                  return UnderlinedContainerWidget(
                    content: ListTile(
                      title: Text(
                        item.toListText(translations.getCurrentLangCode()),
                      ),
                      onTap: () => itemTap(item),
                      trailing: SizedBox(
                        width: iconDim,
                        height: iconDim,
                        child: Image.asset('assets/images/edit.png'),
                      ),
                    ),
                  );
                },
              ),
            ),
            ButtonWidget(
              action: itemAddRequested,
              text: addButtonText,
              type: ButtonWidgetType.standard,
            ),
          ],
        ),
      ),
    );
  }
}
